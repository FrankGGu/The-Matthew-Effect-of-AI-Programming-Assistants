-module(solution).
-export([count_special_quadruplets/1]).

count_special_quadruplets(Nums) ->
    N = length(Nums),
    Count = 0,
    count_special_quadruplets(Nums, 0, N - 1, Count).

count_special_quadruplets(_, I, J, Count) when I >= J -> Count;
count_special_quadruplets(Nums, I, J, Count) ->
    A = lists:nth(I + 1, Nums),
    B = lists:nth(J + 1, Nums),
    if
        A + B == lists:nth(0, Nums) + lists:nth(1, Nums) ->
            count_special_quadruplets(Nums, I + 1, J, Count + 1);
        true ->
            count_special_quadruplets(Nums, I + 1, J, Count)
    end.