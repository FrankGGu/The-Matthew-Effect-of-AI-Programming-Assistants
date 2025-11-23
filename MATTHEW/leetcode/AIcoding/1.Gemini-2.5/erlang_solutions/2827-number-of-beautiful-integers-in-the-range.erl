-module(solution).
-export([countBeautifulIntegers/3]).

countBeautifulIntegers(Low, High, K) ->
    count_up_to(High, K) - count_up_to(Low - 1, K).

count_up_to(N, K) ->
    Digits = integer_to_list(N),
    DigitsList = lists:map(fun(C) -> C - $0 end, Digits),
    Len = length(DigitsList),
    Memo = maps:new(),
    {Result, _FinalMemo} = dp(0, true, true, 0, 0, 0, DigitsList, Len, K, Memo),
    Result.

dp(Index, _Tight, _IsLeadingZero, EvenCount, OddCount, CurrentSumModK, _DigitsList, Len, K, Memo) when Index == Len ->
    case {IsLeadingZero, EvenCount == OddCount, CurrentSumModK == 0} of
        {false, true, true} -> {1, Memo};
        _ -> {0, Memo}
    end;
dp(Index, Tight, IsLeadingZero, EvenCount, OddCount, CurrentSumModK, DigitsList, Len, K, Memo) ->
    State = {Index, Tight, IsLeadingZero, EvenCount, OddCount, CurrentSumModK},
    case maps:find(State, Memo) of
        {ok, Value} -> {Value, Memo};
        _ ->
            UpperLimit = case Tight of
                             true -> lists:nth(Index + 1, DigitsList);
                             false -> 9
                         end,

            {TotalCount, FinalMemo} = lists:foldl(
                fun(Digit, {AccCount, AccMemo}) ->
                    NewTight = Tight andalso (Digit == UpperLimit),
                    case {IsLeadingZero, Digit} of
                        {true, 0} ->
                            {Count, UpdatedMemo} = dp(Index + 1, NewTight, true, EvenCount, OddCount, CurrentSumModK, DigitsList, Len, K, AccMemo),
                            {AccCount + Count, UpdatedMemo};
                        _ ->
                            NewEvenCount = EvenCount + case Digit rem 2 == 0 of true -> 1; false -> 0 end,
                            NewOddCount = OddCount + case Digit rem 2 == 1 of true -> 1; false -> 0 end,
                            NewCurrentSumModK = (CurrentSumModK * 10 + Digit) rem K,
                            {Count, UpdatedMemo} = dp(Index + 1, NewTight, false, NewEvenCount, NewOddCount, NewCurrentSumModK, DigitsList, Len, K, AccMemo),
                            {AccCount + Count, UpdatedMemo}
                    end
                end,
                {0, Memo},
                lists:seq(0, UpperLimit)
            ),

            {TotalCount, maps:put(State, TotalCount, FinalMemo)}
    end.