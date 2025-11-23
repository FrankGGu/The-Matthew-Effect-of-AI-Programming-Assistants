-module(solution).
-export([semi_ordered_permutation/1]).

semi_ordered_permutation(Nums) ->
    L = length(Nums),
    Idx1 = find_index(1, Nums),
    IdxN = find_index(L, Nums),

    Swaps1 = Idx1,

    IdxN_after_1_move = 
        if 
            IdxN > Idx1 -> IdxN;
            true -> IdxN + 1
        end,

    SwapsN = (L - 1) - IdxN_after_1_move,

    Swaps1 + SwapsN.

find_index(Element, List) ->
    find_index(Element, List, 0).

find_index(Element, [Element | _], Index) -> Index;
find_index(Element, [_ | T], Index) -> find_index(Element, T, Index + 1).