-module(solution).
-export([maximum_unique_subarray/1]).

maximum_unique_subarray(Nums) ->
    solve_sliding_window(Nums, Nums, 0, 0, maps:new()).

solve_sliding_window(_LeftList, [], CurrentSum, MaxSum, _Seen) ->
    max(MaxSum, CurrentSum);
solve_sliding_window(LeftList, [RightHead | RightTail], CurrentSum, MaxSum, Seen) ->
    case maps:is_key(RightHead, Seen) of
        true ->
            [LeftHead | LeftTail] = LeftList,
            NewSeen = maps:remove(LeftHead, Seen),
            NewCurrentSum = CurrentSum - LeftHead,
            solve_sliding_window(LeftTail, [RightHead | RightTail], NewCurrentSum, MaxSum, NewSeen);
        false ->
            NewSeen = maps:put(RightHead, true, Seen),
            NewCurrentSum = CurrentSum + RightHead,
            NewMaxSum = max(MaxSum, NewCurrentSum),
            solve_sliding_window(LeftList, RightTail, NewCurrentSum, NewMaxSum, NewSeen)
    end.