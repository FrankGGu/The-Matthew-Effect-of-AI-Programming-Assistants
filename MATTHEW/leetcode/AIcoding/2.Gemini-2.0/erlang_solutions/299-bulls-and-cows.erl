-module(bulls_and_cows).
-export([get_hint/2]).

get_hint(Secret, Guess) ->
    SecretList = string:to_list(Secret),
    GuessList = string:to_list(Guess),
    {Bulls, Cows, _SecretRest, _GuessRest} = calculate_bulls_and_cows(SecretList, GuessList, 0, 0, [], []),
    list_to_string([integer_to_list(Bulls), "A", integer_to_list(Cows), "B"]).

calculate_bulls_and_cows([], [], Bulls, Cows, _SecretRest, _GuessRest) ->
    {Bulls, Cows, [], []};
calculate_bulls_and_cows([S | SecretRest], [G | GuessRest], Bulls, Cows, SecretAcc, GuessAcc) ->
    if S == G ->
        calculate_bulls_and_cows(SecretRest, GuessRest, Bulls + 1, Cows, SecretAcc, GuessAcc);
    true ->
        calculate_bulls_and_cows(SecretRest, GuessRest, Bulls, Cows, [S | SecretAcc], [G | GuessAcc])
    end.