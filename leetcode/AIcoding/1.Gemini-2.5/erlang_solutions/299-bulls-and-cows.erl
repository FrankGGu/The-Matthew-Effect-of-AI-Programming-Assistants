-module(solution).
-export([getHint/2]).

getHint(Secret, Guess) ->
    {Bulls, SecretFreq, GuessFreq} = count_bulls_and_populate_freq(Secret, Guess, 0, list_to_tuple(lists:duplicate(10, 0)), list_to_tuple(lists:duplicate(10, 0))),
    Cows = count_cows(SecretFreq, GuessFreq, 0, 0),
    io_lib:format("~wA~wB", [Bulls, Cows]).

count_bulls_and_populate_freq([], [], Bulls, SecretFreq, GuessFreq) ->
    {Bulls, SecretFreq, GuessFreq};
count_bulls_and_populate_freq([S | Ss], [G | Gs], BullsAcc, SecretFreqAcc, GuessFreqAcc) ->
    SVal = S - $0,
    GVal = G - $0,
    if
        S == G ->
            count_bulls_and_populate_freq(Ss, Gs, BullsAcc + 1, SecretFreqAcc, GuessFreqAcc);
        true ->
            NewSecretFreq = set_freq(SecretFreqAcc, SVal, element(SVal + 1, SecretFreqAcc) + 1),
            NewGuessFreq = set_freq(GuessFreqAcc, GVal, element(GVal + 1, GuessFreqAcc) + 1),
            count_bulls_and_populate_freq(Ss, Gs, BullsAcc, NewSecretFreq, NewGuessFreq)
    end.

set_freq(Tuple, Index, Value) ->
    list_to_tuple(lists:replace_nth(Index + 1, Value, tuple_to_list(Tuple))).

count_cows(SecretFreq, GuessFreq, Index, CowsAcc) when Index < 10 ->
    SCount = element(Index + 1, SecretFreq),
    GCount = element(Index + 1, GuessFreq),
    MinCount = min(SCount, GCount),
    count_cows(SecretFreq, GuessFreq, Index + 1, CowsAcc + MinCount);
count_cows(_SecretFreq, _GuessFreq, _Index, CowsAcc) ->
    CowsAcc.