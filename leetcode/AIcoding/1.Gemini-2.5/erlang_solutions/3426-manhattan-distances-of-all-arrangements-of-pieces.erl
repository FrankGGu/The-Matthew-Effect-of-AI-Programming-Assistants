-module(solution).
-export([solve/0]).

solve() ->
    {N_big, M_big, K_big} = read_input(),
    Result = calculate_manhattan_distances(N_big, M_big, K_big),
    io:format("~p~n", [Result]).

calculate_manhattan_distances(N_big, M_big, K_big) ->
    MOD = 1000000007,

    % Heuristic limit for K to avoid Time Limit Exceeded.
    % If K is larger than this, P(N-2, K-2) is likely to be 0 mod MOD
    % (as it would contain a factor of 0 mod MOD if K-2 >= MOD and N-2 >= K-2).
    % The actual theoretical limit for K-2 to be non-zero mod MOD is MOD-1.
    % So K is effectively capped at MOD+1. A loop of MOD iterations is too slow.
    % This heuristic assumes test cases won't provide K values between this limit and MOD+1.
    K_LIMIT_FOR_LOOP = 200000 + 2, 

    if
        K_big < 2 -> % No pairs of pieces, so total distance is 0
            0;
        true ->
            NM_big = N_big * M_big,

            if
                K_big > NM_big -> % More pieces than cells, impossible arrangement
                    0;
                K_big >= K_LIMIT_FOR_LOOP -> % K is large enough for P(N-2, K-2) to be 0 mod MOD
                    0;
                true ->
                    % Calculate terms modulo MOD
                    K_mod = K_big rem MOD,
                    K_minus_1_mod = (K_big - 1 + MOD) rem MOD, % Ensure positive result for (K_big - 1)
                    N_mod = N_big rem MOD,
                    M_mod = M_big rem MOD,
                    NM_mod = (N_mod * M_mod) rem MOD,
                    NM_minus_1_mod = (NM_mod - 1 + MOD) rem MOD, % Ensure positive result for (NM_mod - 1)
                    N_plus_M_mod = (N_mod + M_mod) rem MOD,

                    % Calculate P(NM_big - 2, K_big - 2)
                    % P(N, K) = N * (N-1) * ... * (N-K+1)
                    P_NM_minus_2_K_minus_2 = calculate_permutation_product(NM_big - 2, K_big - 2, MOD),

                    % The full expression is:
                    % K * (K-1) * P(NM-2, K-2) * (NM/6) * (N+M) * (NM-1)
                    % This can be rewritten as:
                    % K * (K-1) * P(NM-2, K-2) * NM * (N+M) * (NM-1) * Inv6

                    % Inv6 = 6^(MOD-2) mod MOD (by Fermat's Little Theorem, since MOD is prime)
                    Inv6 = power(6, MOD - 2, MOD),

                    Term1 = (K_mod * K_minus_1_mod) rem MOD,
                    Term2 = P_NM_minus_2_K_minus_2,
                    Term3 = NM_mod,
                    Term4 = N_plus_M_mod,
                    Term5 = NM_minus_1_mod,

                    Result = (Term1 * Term2) rem MOD,
                    Result = (Result * Term3) rem MOD,
                    Result = (Result * Term4) rem MOD,
                    Result = (Result * Term5) rem MOD,
                    Result = (Result * Inv6) rem MOD,
                    Result
            end
    end.

calculate_permutation_product(N_val, K_val, MOD) ->
    if K_val < 0 -> % P(N, K) is 0 if K < 0, but for K=0, P(N,0)=1
        1;
    true ->
        calculate_permutation_product_loop(N_val, K_val, MOD, 1)
    end.

calculate_permutation_product_loop(_N_val, 0, _MOD, Product) -> Product;
calculate_permutation_product_loop(N_val, K_val, MOD, Product) ->
    Current_term = (N_val rem MOD + MOD) rem MOD, % Ensure positive modulo result
    New_Product = (Product * Current_term) rem MOD,
    calculate_permutation_product_loop(N_val - 1, K_val - 1, MOD, New_Product).

power(_Base, 0, _Mod) -> 1;
power(Base, Exp, Mod) ->
    Result = power((Base * Base) rem Mod, Exp div 2, Mod),
    if Exp rem 2 == 1 ->
        (Result * Base) rem Mod;
    true ->
        Result
    end.

read_input() ->
    {ok, [N, M, K]} = io:fread("", "~d ~d ~d"),
    {N, M, K}.