-module(solution).
-export([ways_to_split_array_into_good_subarrays/1]).

-spec ways_to_split_array_into_good_subarrays(Nums :: [integer()]) -> integer().
ways_to_split_array_into_good_subarrays(Nums) ->
    Mod = 1000000007,

    OnesIndices = find_ones_indices(Nums, 0, []),

    case OnesIndices of
        [] ->
            0;
        [_] ->
            1;
        [H1 | T1] ->
            calculate_product(T1, H1, 1, Mod)
    end.

find_ones_indices([], _Idx, Acc) ->
    lists:reverse(Acc);
find_ones_indices([H | T], Idx, Acc) ->
    if H == 1 ->
        find_ones_indices(T, Idx + 1, [Idx | Acc]);
    true ->
        find_ones_indices(T, Idx + 1, Acc)
    end.

calculate_product([], _PrevIdx, Product, _Mod) ->
    Product;
calculate_product([CurrentIdx | T], PrevIdx, Product, Mod) ->
    Diff = CurrentIdx - PrevIdx,
    NewProduct = (Product * Diff) rem Mod,
    calculate_product(T, CurrentIdx, NewProduct, Mod).