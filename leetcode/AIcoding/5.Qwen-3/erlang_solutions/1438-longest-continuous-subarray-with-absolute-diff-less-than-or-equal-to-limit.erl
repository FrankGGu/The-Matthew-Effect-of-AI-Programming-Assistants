-module(solution).
-export([longestSubarray/1]).

longestSubarray(Nums) ->
    longestSubarray(Nums, 0, 0, 0, 0, 0).

longestSubarray([], Left, Right, Max, Min, MaxLen) ->
    MaxLen;
longestSubarray(Nums, Left, Right, Max, Min, MaxLen) ->
    Current = lists:nth(Right + 1, Nums),
    NewMax = max(Max, Current),
    NewMin = min(Min, Current),
    if
        NewMax - NewMin =< 10^6 ->
            longestSubarray(Nums, Left, Right + 1, NewMax, NewMin, max(MaxLen, Right - Left + 1));
        true ->
            if
                Left == Right ->
                    longestSubarray(Nums, Left + 1, Right + 1, Current, Current, MaxLen);
                true ->
                    NextLeft = Left + 1,
                    NextVal = lists:nth(NextLeft + 1, Nums),
                    NewMax2 = max(lists:nth(Left + 1, Nums), NextVal),
                    NewMin2 = min(lists:nth(Left + 1, Nums), NextVal),
                    longestSubarray(Nums, NextLeft, Right + 1, NewMax2, NewMin2, MaxLen)
            end
    end.