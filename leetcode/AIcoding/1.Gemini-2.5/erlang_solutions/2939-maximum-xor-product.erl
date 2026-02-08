-module(solution).
-export([maximumXorProduct/3]).

maximumXorProduct(A, B, N) ->
    Mod = 1000000007,
    MaxBitIdx = 59, % A, B <= 10^18. The maximum bit index that can be set is 59 (since 2^60 > 10^18).

    % Initialize a_prime and b_prime with the fixed higher bits (i >= N)
    % For bits i >= N, (A XOR X)_i = A_i and (B XOR Y)_i = B_i because X_i=0, Y_i=0.
    InitialResA = 0,
    InitialResB = 0,
    {FinalResA_fixed, FinalResB_fixed} = lists:foldl(
        fun(I, {CurrentA, CurrentB}) ->
            BitA = (A bsr I) band 1,
            BitB = (B bsr I) band 1,
            {CurrentA bor (BitA bsl I), CurrentB bor (BitB bsl I)}
        end,
        {InitialResA, InitialResB},
        lists:seq(MaxBitIdx, N, -1) % Iterate from MaxBitIdx down to N
    ),

    % For bits i < N, we can choose A'_i and B'_i independently (0 or 1)
    {FinalResA_chosen, FinalResB_chosen} = lists:foldl(
        fun(I, {CurrentA, CurrentB}) ->
            % Calculate the maximum possible value for the remaining lower bits (i-1 down to 0)
            % This is (2^I - 1)
            RemMask = (1 bsl I) - 1,

            % Option 1: Set A'_i = 1, B'_i = 1
            CandA1 = CurrentA bor (1 bsl I),
            CandB1 = CurrentB bor (1 bsl I),
            Prod1 = (CandA1 + RemMask) * (CandB1 + RemMask),

            % Option 2: Set A'_i = 0, B'_i = 0
            CandA0 = CurrentA,
            CandB0 = CurrentB,
            Prod0 = (CandA0 + RemMask) * (CandB0 + RemMask),

            % Option 3: Set A'_i = 1, B'_i = 0
            CandA10 = CurrentA bor (1 bsl I),
            CandB10 = CurrentB,
            Prod10 = (CandA10 + RemMask) * (CandB10 + RemMask),

            % Option 4: Set A'_i = 0, B'_i = 1
            CandA01 = CurrentA,
            CandB01 = CurrentB bor (1 bsl I),
            Prod01 = (CandA01 + RemMask) * (CandB01 + RemMask),

            % Choose the option that yields the maximum hypothetical product
            MaxProd = lists:max([Prod1, Prod0, Prod10, Prod01]),

            % Update CurrentA and CurrentB based on the chosen option
            if
                MaxProd == Prod1 -> {CandA1, CandB1};
                MaxProd == Prod0 -> {CandA0, CandB0};
                MaxProd == Prod10 -> {CandA10, CandB10};
                MaxProd == Prod01 -> {CandA01, CandB01}
            end
        end,
        {FinalResA_fixed, FinalResB_fixed},
        lists:seq(N - 1, 0, -1) % Iterate from N-1 down to 0
    ),

    (FinalResA_chosen * FinalResB_chosen) rem Mod.