-spec get_hint(Secret :: unicode:unicode_binary(), Guess :: unicode:unicode_binary()) -> unicode:unicode_binary().
get_hint(Secret, Guess) ->
    {Bulls, Cows} = count_bulls_and_cows(Secret, Guess, 0, 0, [], []),
    io:format("~pA~pB", [Bulls, Cows]).

count_bulls_and_cows([], [], Bulls, Cows, _, _) -> {Bulls, Cows};
count_bulls_and_cows([H1 | T1], [H2 | T2], Bulls, Cows, SecretRemainder, GuessRemainder) ->
    if
        H1 =:= H2 ->
            count_bulls_and_cows(T1, T2, Bulls + 1, Cows, SecretRemainder, GuessRemainder);
        true ->
            count_bulls_and_cows(T1, T2, Bulls, Cows, [H1 | SecretRemainder], [H2 | GuessRemainder])
    end.

count_bulls_and_cows(Secret, Guess, Bulls, Cows, SecretRemainder, GuessRemainder) ->
    {Bulls, Cows + count_cows(SecretRemainder, GuessRemainder)}.

count_cows([], _) -> 0;
count_cows([H | T], GuessRemainder) ->
    case lists:member(H, GuessRemainder) of
        true -> 1 + count_cows(T, lists:delete(H, GuessRemainder));
        false -> count_cows(T, GuessRemainder)
    end.
