-module(solution).
-export([countBeautifulNumbers/3]).

countBeautifulNumbers(LowStr, HighStr, K) ->
    CountHigh = solve(HighStr, K),
    LowMinusOneStr = subtract_one(LowStr),
    CountLowMinusOne = solve(LowMinusOneStr, K),
    CountHigh - CountLowMinusOne.

subtract_one(S) ->
    Num = list_to_integer(S),
    integer_to_list(Num - 1).

solve(S, K) ->
    {Result, _FinalMemo} = dp(0, 0, true, true, S, K, gb_trees:empty()),
    Result.

dp(Index, CurrentSumModK, IsTight, IsLeadingZero, S, K, Memo) ->
    Len = length(S),
    if Index == Len ->
        if IsLeadingZero -> {0, Memo}; % If only leading zeros were placed, it's 0, which is not a positive beautiful number.
        else -> {if CurrentSumModK == 0 then 1 else 0 end, Memo}
        end;
    true ->
        Key = {Index, CurrentSumModK, IsTight, IsLeadingZero},
        case gb_trees:lookup(Key, Memo) of
            {value, Val} -> {Val, Memo};
            none ->
                UpperLimitChar = lists:nth(Index + 1, S), % Erlang lists are 1-indexed for lists:nth
                UpperLimit = if IsTight then list_to_integer([UpperLimitChar]) else 9 end,

                {Ans, FinalMemo} = lists:foldl(
                    fun(Digit, {AccSum, AccMemo}) ->
                        NewIsTight = IsTight and (Digit == UpperLimit),
                        {SubResult, UpdatedMemo} =
                            if IsLeadingZero and (Digit == 0) ->
                                % Still placing leading zeros, sum doesn't change
                                dp(Index + 1, CurrentSumModK, NewIsTight, true, S, K, AccMemo);
                            true ->
                                % Placed a non-zero digit or already past leading zeros
                                NewSumModK = (CurrentSumModK + Digit) rem K,
                                dp(Index + 1, NewSumModK, NewIsTight, false, S, K, AccMemo)
                            end,
                        {AccSum + SubResult, UpdatedMemo}
                    end,
                    {0, Memo},
                    lists:seq(0, UpperLimit)
                ),
                {Ans, gb_trees:insert(Key, Ans, FinalMemo)}
        end
    end.