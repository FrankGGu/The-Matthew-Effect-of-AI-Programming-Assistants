-module(solution).
-export([longestSubsequence/2]).

longestSubsequence(Arr, Difference) ->
    {MaxLen, _DPMap} = lists:foldl(
        fun(Num, {AccMaxLen, AccDPMap}) ->
            PrevVal = Num - Difference,
            LenPrev = maps:get(PrevVal, AccDPMap, 0),
            NewLen = LenPrev + 1,
            NewDPMap = maps:put(Num, NewLen, AccDPMap),
            NewMaxLen = max(AccMaxLen, NewLen),
            {NewMaxLen, NewDPMap}
        end,
        {1, #{}}, % Initial accumulator: MaxLen starts at 1 (as arr.length >= 1), DPMap is empty
        Arr
    ),
    MaxLen.