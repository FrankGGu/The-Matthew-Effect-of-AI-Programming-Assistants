-module(minimum_time_to_remove_all_cars_containing_illegal_goods).
-export([minimumTime/1]).

minimumTime(Blocks) ->
    N = length(Blocks),
    Left = lists:seq(0, N-1),
    Right = lists:reverse(lists:seq(0, N-1)),
    LeftDist = compute_distances(Blocks, Left),
    RightDist = compute_distances(Blocks, Right),
    lists:foldl(fun(I, Acc) -> min(Acc, LeftDist ! I + RightDist ! I) end, infinity, lists:seq(0, N-1)).

compute_distances([], _) ->
    [];
compute_distances([H | T], []) ->
    [0];
compute_distances([H | T], [I | Is]) ->
    if
        H == $F ->
            [0 | compute_distances(T, Is)];
        true ->
            [lists:nth(I+1, compute_distances(T, Is)) + 1 | compute_distances(T, Is)]
    end.