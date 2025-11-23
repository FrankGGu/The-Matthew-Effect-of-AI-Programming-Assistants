-module(solution).
-export([min_operations/2]).

min_operations(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    lists:map(fun(Q) -> solve_for_q(SortedNums, Q) end, Queries).

solve_for_q(SortedNums, Q) ->
    find_smallest_divisor_index(SortedNums, Q, 0).

find_smallest_divisor_index([], _Q, _Index) ->
    -1;
find_smallest_divisor_index([H|T], Q, Index) ->
    case Q rem H == 0 of
        true ->
            Index;
        false ->
            find_smallest_divisor_index(T, Q, Index + 1)
    end.