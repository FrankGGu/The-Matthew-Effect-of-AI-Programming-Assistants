-module(solution).
-export([decode/1]).

decode(Encoded) ->
    N = length(Encoded) + 1,

    % Calculate TotalXOR = 1 XOR 2 XOR ... XOR N
    TotalXOR = lists:foldl(fun(I, Acc) -> I bxor Acc end, 0, lists:seq(1, N)),

    % Calculate X = encoded[1] XOR encoded[3] XOR ... XOR encoded[N-2]
    % These are elements at 0-based indices 1, 3, 5, ... N-2.
    X = calculate_X_sum(Encoded, 0, 0),

    P0 = TotalXOR bxor X,

    % Build the permutation list
    build_perm(Encoded, [P0], P0).

calculate_X_sum([], _CurrentIdx, Acc) -> Acc;
calculate_X_sum([_H | T], CurrentIdx, Acc) when CurrentIdx rem 2 == 0 ->
    % If CurrentIdx is even (0, 2, 4, ...), skip this element
    calculate_X_sum(T, CurrentIdx + 1, Acc);
calculate_X_sum([H | T], CurrentIdx, Acc) when CurrentIdx rem 2 == 1 ->
    % If CurrentIdx is odd (1, 3, 5, ...), include this element in XOR sum
    calculate_X_sum(T, CurrentIdx + 1, H bxor Acc).

build_perm([], PermAcc, _LastP) -> lists:reverse(PermAcc);
build_perm([H | T], PermAcc, LastP) ->
    NextP = LastP bxor H,
    build_perm(T, [NextP | PermAcc], NextP).