-module(solution).
-export([find_smallest_missing/1]).

find_smallest_missing(Nums) ->
    Max = lists:max(Nums),
    Set = sets:from_list(Nums),
    find_smallest_missing(Set, 0, Max).

find_smallest_missing(_, N, Max) when N > Max ->
    Max + 1;
find_smallest_missing(Set, N, _) ->
    case sets:is_element(N, Set) of
        true -> find_smallest_missing(Set, N + 1, lists:max(sets:to_list(Set)));
        false -> N
    end.