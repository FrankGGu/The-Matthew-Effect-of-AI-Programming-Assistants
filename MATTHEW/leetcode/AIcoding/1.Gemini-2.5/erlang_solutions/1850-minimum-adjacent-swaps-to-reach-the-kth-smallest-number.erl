-module(solution).
-export([getMinSwaps/2]).

getMinSwaps(Num, K) ->
    OriginalList = string_to_list(Num),
    KthPermutationList = get_kth_permutation(OriginalList, K),
    count_swaps(OriginalList, KthPermutationList).

string_to_list(S) ->
    [X - $0 || X <- S].

get_kth_permutation(NumList, K) ->
    get_kth_permutation_loop(NumList, K, 0).

get_kth_permutation_loop(CurrentList, K, Count) when Count < K ->
    Next = next_permutation(CurrentList),
    get_kth_permutation_loop(Next, K, Count + 1);
get_kth_permutation_loop(CurrentList, _, _) ->
    CurrentList.

next_permutation(L) ->
    Len = length(L),
    I = find_pivot_index(L, Len - 2),
    case I of
        -1 ->
            lists:reverse(L);
        _ ->
            J = find_swap_index(L, I, Len - 1),
            SwappedL = swap_elements(L, I, J),
            {Prefix, Suffix} = lists:split(I + 1, SwappedL),
            Prefix ++ lists:reverse(Suffix)
    end.

find_pivot_index(L, CurrentI) when CurrentI >= 0 ->
    case lists:nth(CurrentI + 1, L) < lists:nth(CurrentI + 2, L) of
        true -> CurrentI;
        false -> find_pivot_index(L, CurrentI - 1)
    end;
find_pivot_index(_, -1) -> -1.

find_swap_index(L, PivotI, CurrentJ) when CurrentJ > PivotI ->
    case lists:nth(CurrentJ + 1, L) > lists:nth(PivotI + 1, L) of
        true -> CurrentJ;
        false -> find_swap_index(L, PivotI, CurrentJ - 1)
    end.

swap_elements(L, I, J) ->
    Li = lists:nth(I + 1, L),
    Lj = lists:nth(J + 1, L),
    L1 = lists:replace_nth(I + 1, Lj, L),
    lists:replace_nth(J + 1, Li, L1).

count_swaps(OriginalList, TargetList) ->
    count_swaps_recursive(OriginalList, TargetList, 0).

count_swaps_recursive([], [], AccSwaps) -> AccSwaps;
count_swaps_recursive(CurrentOriginal, [H_target | T_target], AccSwaps) ->
    {SwapsForThisElement, NewCurrentOriginal} = find_and_move(H_target, CurrentOriginal, 0, []),
    count_swaps_recursive(NewCurrentOriginal, T_target, AccSwaps + SwapsForThisElement).

find_and_move(Element, [Element | T], Swaps, Prefix) ->
    {Swaps, Prefix ++ T};
find_and_move(Element, [H | T], Swaps, Prefix) ->
    find_and_move(Element, T, Swaps + 1, Prefix ++ [H]).