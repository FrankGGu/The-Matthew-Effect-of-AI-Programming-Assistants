-module(prev_permutation_with_one_swap).
-export([prevPermOpt1/1]).

prevPermOpt1(List) ->
    Len = length(List),
    I = find_i(Len, List),
    if
        I == -1 -> List;
        true ->
            J = find_j(I, List),
            swap(I, J, List)
    end.

find_i(N, List) ->
    find_i(N - 1, N - 1, List).

find_i(I, N, List) when I >= 0 ->
    case lists:nth(I + 1, List) < lists:nth(I, List) of
        true -> I;
        false -> find_i(I - 1, N, List)
    end;
find_i(_, _, _) -> -1.

find_j(I, List) ->
    find_j(I, length(List) - 1, lists:nth(I, List), List).

find_j(I, J, Val, List) when J > I ->
    if
        lists:nth(J, List) < Val -> J;
        true -> find_j(I, J - 1, Val, List)
    end;
find_j(_, J, _, _) -> J.

swap(I, J, List) ->
    A = lists:nth(I + 1, List),
    B = lists:nth(J + 1, List),
    lists:sublist(List, I) ++ [B] ++ lists:sublist(List, I + 2, J - I - 1) ++ [A] ++ lists:sublist(List, J + 2).