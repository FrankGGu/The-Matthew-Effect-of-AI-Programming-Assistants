-module(solution).
-export([minimize_hamming_distance/3]).

minimize_hamming_distance(A, B, swaps) ->
    {A1, B1} = swap_elements(A, B, swaps),
    calculate_hamming_distance(A1, B1).

swap_elements(A, B, Swaps) ->
    lists:foldl(fun({i, j}, {A, B}) ->
        {swap(A, i, j), swap(B, i, j)}
    end, {A, B}, Swaps).

swap(List, I, J) ->
    ElementI = lists:nth(I + 1, List),
    ElementJ = lists:nth(J + 1, List),
    lists:mapfun(fun
        X when X =:= ElementI -> ElementJ;
        X when X =:= ElementJ -> ElementI;
        X -> X
    end, List).

calculate_hamming_distance(A, B) ->
    lists:foldl(fun({X, Y}, Acc) -> Acc + (if X =:= Y -> 0; true -> 1 end) end, 0, lists:zip(A, B).