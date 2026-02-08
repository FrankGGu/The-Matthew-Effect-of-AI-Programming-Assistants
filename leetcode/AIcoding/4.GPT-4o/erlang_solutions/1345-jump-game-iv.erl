-module(solution).
-export([min_jumps/1]).

min_jumps(A) ->
    N = length(A),
    if
        N == 1 -> 0;
        true -> 
            Queue = [{0, 0}],
            Visited = sets:from_list([0]),
            min_jumps_helper(Queue, Visited, A, N)
    end.

min_jumps_helper([], _, _, _) ->
    -1;
min_jumps_helper([{Index, Jumps} | Rest], Visited, A, N) ->
    if
        Index == N - 1 -> Jumps;
        true ->
            NextVisited = Visited,
            NextJumps = Jumps + 1,
            NextPositions = get_next_positions(Index, A, N, Visited),
            NewQueue = lists:foldl(fun(P, Acc) -> [{P, NextJumps} | Acc] end, Rest, NextPositions),
            min_jumps_helper(NewQueue, NextVisited, A, N)
    end.

get_next_positions(Index, A, N, Visited) ->
    Value = lists:nth(Index + 1, A),
    Indices = lists:seq(0, N - 1),
    Jumps = lists:filter(fun(I) -> I > Index andalso I < N andalso not(sets:is_element(I, Visited)) andalso (lists:nth(I + 1, A) == Value orelse I == Index + 1) end, Indices),
    lists:foldl(fun(I, Acc) -> sets:add(I, Acc) end, Visited, Jumps).