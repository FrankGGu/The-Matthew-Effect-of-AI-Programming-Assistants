-module(solution).
-export([decode_ways/1]).

decode_ways(S) ->
    StrList = string:to_list(S),
    N = length(StrList),
    {Result, _FinalMemo} = do_decode(0, StrList, N, #{}),
    Result.

do_decode(N, _, _, Memo) -> {1, Memo};
do_decode(Idx, _, N, Memo) when Idx > N -> {0, Memo};
do_decode(Idx, StrList, N, Memo) ->
    case maps:find(Idx, Memo) of
        {ok, Result} -> {Result, Memo};
        error ->
            Char1 = lists:nth(Idx + 1, StrList),
            if Char1 == $0 ->
                Result = 0,
                NewMemo = maps:put(Idx, Result, Memo),
                {Result, NewMemo};
            true ->
                {Ways1, Memo1} = do_decode(Idx + 1, StrList, N, Memo),
                CurrentResult = Ways1,
                CurrentMemo = Memo1,

                if Idx + 1 < N ->
                    Char2 = lists:nth(Idx + 1 + 1, StrList),
                    Val1 = Char1 - $0,
                    Val2 = Char2 - $0,
                    TwoDigitNum = Val1 * 10 + Val2,
                    if TwoDigitNum >= 10 and TwoDigitNum <= 26 ->
                        {Ways2, Memo2} = do_decode(Idx + 2, StrList, N, CurrentMemo),
                        Result = CurrentResult + Ways2,
                        NewMemo = maps:put(Idx, Result, Memo2),
                        {Result, NewMemo};
                    true ->
                        Result = CurrentResult,
                        NewMemo = maps:put(Idx, Result, CurrentMemo),
                        {Result, NewMemo}
                    end;
                true ->
                    Result = CurrentResult,
                    NewMemo = maps:put(Idx, Result, CurrentMemo),
                    {Result, NewMemo}
                end
            end
    end.