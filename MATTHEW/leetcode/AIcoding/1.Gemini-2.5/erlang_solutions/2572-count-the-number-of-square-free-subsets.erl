-module(solution).
-export([squareFreeSubsets/1]).

-define(MOD, 1000000007).
-define(PRIMES, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]).

get_prime_idx(P) ->
    case P of
        2 -> 0;
        3 -> 1;
        5 -> 2;
        7 -> 3;
        11 -> 4;
        13 -> 5;
        17 -> 6;
        19 -> 7;
        23 -> 8;
        29 -> 9;
        _ -> throw({error, "Not a relevant prime"}) %% Should not happen for numbers <= 30
    end.

is_square_free(N) ->
    N rem 4 =/= 0 andalso N rem 9 =/= 0 andalso N rem 25 =/= 0.

get_prime_mask(N) ->
    lists:foldl(fun(P, Mask) ->
        if N rem P == 0 -> Mask bor (1 bsl get_prime_idx(P));
           true -> Mask
        end
    end, 0, ?PRIMES).

power(_, 0, Mod) -> 1;
power(Base, Exp, Mod) ->
    Result = power(Base, Exp div 2, Mod),
    Squared = (Result * Result) rem Mod,
    if Exp rem 2 == 1 -> (Squared * Base) rem Mod;
       true -> Squared
    end.

squareFreeSubsets(Nums) ->
    %% Step 1: Count ones and filter/process other numbers
    {CountOne, SFNumsWithMasks} =
        lists:foldl(fun(Num, {AccCountOne, AccSFNums}) ->
            if Num == 1 -> {AccCountOne + 1, AccSFNums};
               is_square_free(Num) ->
                   Mask = get_prime_mask(Num),
                   {AccCountOne, [{Num, Mask} | AccSFNums]};
               true -> {AccCountOne, AccSFNums}
            end
        end, {0, []}, Nums),

    %% Step 2: Group SFNumsWithMasks by {Num, Mask} and count frequencies
    FreqMap = lists:foldl(fun({Num, Mask}, AccMap) ->
        Key = {Num, Mask},
        maps:update_with(Key, fun(Val) -> Val + 1 end, 1, AccMap)
    end, #{}, SFNumsWithMasks),

    %% Step 3: Dynamic Programming
    %% dp is a map where keys are masks and values are counts
    %% Initialize dp with dp[0] = 1 (for the empty set)
    DP = maps:put(0, 1, #{}),

    FinalDP = maps:fold(fun({_Num, Mask}, Count, AccDP) ->
        %% Iterate through existing dp states (masks)
        %% Create a list of {OldMask, OldCount} pairs from AccDP to avoid modifying during iteration
        lists:foldl(fun({OldMask, OldWays}, CurrentDP) ->
            if (Mask band OldMask) == 0 -> %% If no common prime factors
                NewMask = Mask bor OldMask,
                WaysToAdd = (OldWays * Count) rem ?MOD,
                maps:update_with(NewMask, fun(Val) -> (Val + WaysToAdd) rem ?MOD end, WaysToAdd, CurrentDP);
               true -> CurrentDP
            end
        end, AccDP, maps:to_list(AccDP))
    end, DP, FreqMap),

    %% Step 4: Sum all ways in FinalDP
    TotalSubsetsWithoutOnes = lists:foldl(fun({_Mask, Ways}, AccSum) ->
        (AccSum + Ways) rem ?MOD
    end, 0, maps:to_list(FinalDP)),

    %% Step 5: Multiply by 2^CountOne (for the '1's in the input)
    PowerOfTwo = power(2, CountOne, ?MOD),
    (TotalSubsetsWithoutOnes * PowerOfTwo) rem ?MOD.