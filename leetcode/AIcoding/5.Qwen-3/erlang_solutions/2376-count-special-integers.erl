-module(solution).
-export([count_special_integers/1]).

count_special_integers(N) ->
    NStr = integer_to_list(N),
    len = length(NStr),
    {_, Result} = dfs(0, 0, 0, true, true, NStr, len),
    Result.

dfs(Pos, Mask, Count, Tight, Leading, NStr, Len) ->
    if
        Pos == Len ->
            {0, 1};
        true ->
            MaxDigit = if
                Tight -> list_to_integer(lists:nth(Pos+1, NStr));
                true -> 9
            end,
            Total = 0,
            NewTight = Tight and (Pos == 0),
            NewLeading = Leading,
            Res = 0,
            lists:foreach(
                fun(Digit) ->
                    NewTightFlag = Tight and (Digit == MaxDigit),
                    NewLeadingFlag = Leading and (Digit == 0),
                    NewMask = if
                        Leading and (Digit == 0) -> Mask;
                        true -> Mask bor (1 bsl Digit)
                    end,
                    NewCount = Count + (if Leading and (Digit == 0) -> 0; true -> 1 end),
                    {SubTotal, SubRes} = dfs(Pos+1, NewMask, NewCount, NewTightFlag, NewLeadingFlag, NStr, Len),
                    Total = Total + SubTotal,
                    Res = Res + SubRes
                end,
                lists:seq(0, MaxDigit)
            ),
            {Total, Res}
    end.