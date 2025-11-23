-module(solution).
-export([rand10/0]).

rand10() ->
    generate_rand10().

generate_rand10() ->
    Val1 = rand7() - 1, %% Generates a number from 0 to 6
    Val2 = rand7() - 1, %% Generates a number from 0 to 6

    %% Combine them to get a number in a larger range.
    %% (Val1 * 7) gives 0, 7, 14, 21, 28, 35, 42
    %% Adding Val2 (0-6) results in a uniform distribution from 0 to 48.
    Combined = Val1 * 7 + Val2,

    %% We need rand10() which is 1-10.
    %% The range 0-48 has 49 possible outcomes.
    %% We can use the first 40 outcomes (0-39) to generate rand10().
    %% If Combined is 40 or greater, we re-roll.
    if
        Combined < 40 ->
            (Combined rem 10) + 1; %% Map 0-39 to 1-10 uniformly
        true ->
            generate_rand10() %% Re-roll if Combined is 40-48
    end.