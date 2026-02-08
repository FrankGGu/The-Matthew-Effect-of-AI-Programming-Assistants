-module(couples_holding_hands).
-export([min_swaps_couples/1]).

min_swaps_couples(Row) ->
    N = length(Row) div 2,
    P = lists:seq(0, N - 1),
    id(Row, P, 0).

id([], _, Count) ->
    Count;
id([A, B | Rest], P, Count) ->
    Pa = find(A div 2, P),
    Pb = find(B div 2, P),
    if Pa == Pb ->
        id(Rest, P, Count)
    else
        swap(A div 2, B div 2, P, Count).

find(X, P) ->
    find_helper(X, P, 0).

find_helper(X, [H | T], Index) ->
    if H == X ->
        Index
    else
        find_helper(X, T, Index + 1).

swap(A, B, P, Count) ->
    {NewP, _} = swap_helper(A, B, P, 0, []),
    id(get_row(NewP), NewP, Count + 1).

swap_helper(A, B, [H | T], Index, Acc) ->
    if Index == A ->
        swap_helper(A, B, T, Index + 1, Acc ++ [element(B, get_row(P)) div 2])
    else if Index == B ->
        swap_helper(A, B, T, Index + 1, Acc ++ [element(A, get_row(P)) div 2])
    else
        swap_helper(A, B, T, Index + 1, Acc ++ [H]);
swap_helper(_, _, [], _, Acc) ->
    {Acc, true}.

get_row(P) ->
    get_row_helper(P, []).

get_row_helper([], Acc) ->
    lists:reverse(Acc);
get_row_helper([H | T], Acc) ->
    get_row_helper(T, Acc ++ [2 * H, 2 * H + 1]).