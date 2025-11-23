-module(solution).
-export([find_max_k/1]).

find_max_k(Nums) ->
    Set = sets:from_list(Nums),
    PositiveNums = [N || N <- Nums, N > 0],
    SortedPositiveNums = lists:sort(fun(A, B) -> A >= B end, PositiveNums),
    find_max_k_recursive(SortedPositiveNums, Set).

find_max_k_recursive([], _Set) ->
    -1;
find_max_k_recursive([N | Rest], Set) ->
    case sets:is_element(-N, Set) of
        true -> N;
        false -> find_max_k_recursive(Rest, Set)
    end.