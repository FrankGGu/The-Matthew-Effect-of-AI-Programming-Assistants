-module(solution).
-export([constructArray/2]).

constructArray(N, K) ->
    % Phase 1: Generate K+1 elements to create K distinct differences.
    % The pattern alternates between the smallest available number (Left)
    % and the largest available number (Right).
    % The elements are built into an accumulator list in reverse order.
    P1 = generate_first_k_plus_1(K, 1, K + 1, [], 1),

    % Phase 2: Append the remaining N - (K+1) elements in increasing order.
    % These elements will only introduce a difference of 1, which is already
    % present from Phase 1, thus not adding new distinct differences.
    % The numbers used in Phase 1 are 1 to K+1. So, the next number is K+2.
    P2 = lists:seq(K + 2, N),

    % Reverse P1 to get the correct order, then concatenate with P2.
    lists:reverse(P1) ++ P2.

generate_first_k_plus_1(K_val, Left, Right, Acc, Idx) when Idx =< K_val + 1 ->
    % Idx is the current 1-based index of the element being added.
    % If Idx is odd, add Left and increment Left.
    % If Idx is even, add Right and decrement Right.
    if Idx rem 2 == 1 ->
        generate_first_k_plus_1(K_val, Left + 1, Right, [Left | Acc], Idx + 1)
    else
        generate_first_k_plus_1(K_val, Left, Right - 1, [Right | Acc], Idx + 1)
    end;
generate_first_k_plus_1(_K_val, _Left, _Right, Acc, _Idx) ->
    % Base case: K+1 elements have been generated.
    Acc.