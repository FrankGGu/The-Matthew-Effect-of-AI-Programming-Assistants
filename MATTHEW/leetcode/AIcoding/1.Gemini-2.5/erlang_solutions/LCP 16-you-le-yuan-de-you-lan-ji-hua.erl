-module(solution).
-export([waysToExpressSumOfPowers/2]).

-spec power(integer(), integer()) -> integer().
power(Base, Exp) when Exp == 0 -> 1;
power(Base, Exp) when Exp rem 2 == 0 ->
    Half = power(Base, Exp div 2),
    Half * Half;
power(Base, Exp) ->
    Base * power(Base, Exp - 1).

-spec waysToExpressSumOfPowers(integer(), integer()) -> integer().
waysToExpressSumOfPowers(N, X) ->
    MOD = 1000000007,

    % Initialize dp array: dp[0] = 1 (one way to make sum 0, by choosing no numbers),
    % all other dp[j] are 0.
    % We use Erlang's `array` module for efficient O(1) element access and update.
    DP = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),
    DP_initial = array:set(0, 1, DP), % Set dp[0] to 1

    % This recursive function implements the outer loop, iterating through unique positive integers `CurrentI`.
    % It accumulates the updated DP array.
    loop_i(CurrentI, CurrentDP) ->
        P = power(CurrentI, X), % Calculate the x-th power of CurrentI

        if P > N ->
            % If P exceeds N, no further powers of CurrentI or larger integers can be used.
            % We stop and return the current DP array.
            CurrentDP;
        true ->
            % This `lists:foldl` implements the inner loop, iterating `J` from N down to P.
            % Iterating downwards ensures that each power `P` (corresponding to `CurrentI`)
            % is used at most once for any given sum `J`.
            UpdatedDP = lists:foldl(
                fun(J, AccDP) ->
                    % If J is less than P, we cannot include P in the sum J, so AccDP remains unchanged.
                    % This condition is implicitly handled by `lists:seq(N, P, -1)`.
                    % dp[J] = (dp[J] + dp[J - P]) % MOD
                    ValJ = array:get(J, AccDP),
                    ValJ_minus_P = array:get(J - P, AccDP),
                    array:set(J, (ValJ + ValJ_minus_P) rem MOD, AccDP)
                end,
                CurrentDP,
                lists:seq(N, P, -1) % Generate a list of J values from N down to P
            ),
            % Recurse for the next unique positive integer (CurrentI + 1) with the updated DP array.
            loop_i(CurrentI + 1, UpdatedDP)
        end
    end,

    % Start the dynamic programming process from CurrentI = 1.
    FinalDP = loop_i(1, DP_initial),

    % The result is the number of ways to express N, which is stored in dp[N].
    array:get(N, FinalDP).