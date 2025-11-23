-module(solution).
-export([maximum_triplet_value/1]).

maximum_triplet_value(Nums) ->
    N = length(Nums),
    Nums_tuple = list_to_tuple(Nums),
    calculate_max(1, N, Nums_tuple, 0).

calculate_max(I, N, Nums_tuple, CurrentMax) when I =< N - 2 ->
    Ni = element(I, Nums_tuple),
    CurrentMax_after_J_loop = calculate_max_j(I + 1, N, Nums_tuple, Ni, CurrentMax),
    calculate_max(I + 1, N, Nums_tuple, CurrentMax_after_J_loop);
calculate_max(_, _, _, CurrentMax) ->
    CurrentMax.

calculate_max_j(J, N, Nums_tuple, Ni, CurrentMax) when J =< N - 1 ->
    Nj = element(J, Nums_tuple),
    CurrentMax_after_K_loop = calculate_max_k(J + 1, N, Nums_tuple, Ni, Nj, CurrentMax),
    calculate_max_j(J + 1, N, Nums_tuple, Ni, CurrentMax_after_K_loop);
calculate_max_j(_, _, _, _, CurrentMax) ->
    CurrentMax.

calculate_max_k(K, N, Nums_tuple, Ni, Nj, CurrentMax) when K =< N ->
    Nk = element(K, Nums_tuple),
    TripletValue = (Ni - Nj) * Nk,
    NewMax = max(CurrentMax, TripletValue),
    calculate_max_k(K + 1, N, Nums_tuple, Ni, Nj, NewMax);
calculate_max_k(_, _, _, _, _, CurrentMax) ->
    CurrentMax.