-module(solution).
-export([common_prefix/2]).

common_prefix(A, B) ->
    N = length(A),
    C = lists:seq(1, N),
    common_prefix(A, B, C, 1, []).

common_prefix(_, _, [], _, Acc) ->
    lists:reverse(Acc);
common_prefix(A, B, [I|Is], Pos, Acc) ->
    A_elem = lists:nth(Pos, A),
    B_elem = lists:nth(Pos, B),
    A_set = sets:from_list(lists:sublist(A, Pos)),
    B_set = sets:from_list(lists:sublist(B, Pos)),
    Common = sets:intersection(A_set, B_set),
    Acc1 = [sets:size(Common) | Acc],
    common_prefix(A, B, Is, Pos + 1, Acc1).