-module(solution).
-export([distributeCandies/2]).

combination(N, K) when K < 0; K > N -> 0;
combination(N, 0) -> 1;
combination(N, N) -> 1;
combination(N, 1) -> N;
combination(N, 2) when N >= 2 -> (N * (N - 1)) div 2;
combination(_N, 2) -> 0. %% Handles cases where N < 2 for K=2

distributeCandies(N, Limit) ->
    %% This problem is a classic stars and bars problem with an upper limit.
    %% We use the Principle of Inclusion-Exclusion.
    %% We want to find the number of integer solutions to x1 + x2 + x3 = N
    %% such that 0 <= xi <= Limit for i = 1, 2, 3.

    %% 1. Total ways without any upper limit (0 <= xi): C(N + k - 1, k - 1) where k=3 children.
    %%    C(N + 3 - 1, 3 - 1) = C(N + 2, 2)
    Term1 = combination(N + 2, 2),

    %% 2. Subtract ways where at least one child exceeds the limit (xi > Limit).
    %%    Let xi' = xi - (Limit + 1). So xi = xi' + Limit + 1.
    %%    If x1 > Limit, then x1' + Limit + 1 + x2 + x3 = N
    %%    x1' + x2 + x3 = N - (Limit + 1)
    %%    Number of ways: C((N - (Limit + 1)) + 2, 2) = C(N - Limit + 1, 2)
    %%    There are 3 such children, so 3 * C(N - Limit + 1, 2)
    Term2_N = N - Limit + 1,
    Term2 = 3 * combination(Term2_N, 2),

    %% 3. Add back ways where at least two children exceed the limit (xi > Limit, xj > Limit).
    %%    If x1 > Limit and x2 > Limit:
    %%    x1' + Limit + 1 + x2' + Limit + 1 + x3 = N
    %%    x1' + x2' + x3 = N - 2*(Limit + 1)
    %%    Number of ways: C((N - 2*(Limit + 1)) + 2, 2) = C(N - 2*Limit, 2)
    %%    There are C(3, 2) = 3 such pairs, so 3 * C(N - 2*Limit, 2)
    Term3_N = N - 2*Limit,
    Term3 = 3 * combination(Term3_N, 2),

    %% 4. Subtract ways where all three children exceed the limit (x1 > Limit, x2 > Limit, x3 > Limit).
    %%    If x1 > Limit, x2 > Limit, x3 > Limit:
    %%    x1' + Limit + 1 + x2' + Limit + 1 + x3' + Limit + 1 = N
    %%    x1' + x2' + x3' = N - 3*(Limit + 1)
    %%    Number of ways: C((N - 3*(Limit + 1)) + 2, 2) = C(N - 3*Limit - 1, 2)
    %%    There is C(3, 3) = 1 such triplet, so 1 * C(N - 3*Limit - 1, 2)
    Term4_N = N - 3*Limit - 1,
    Term4 = combination(Term4_N, 2),

    Result = Term1 - Term2 + Term3 - Term4,

    %% The result might be negative due to the inclusion-exclusion principle if N is too small
    %% for any valid distribution to exist. In such cases, the answer is 0.
    max(0, Result).