-spec get_hint(Secret :: unicode:unicode_binary(), Guess :: unicode:unicode_binary()) -> unicode:unicode_binary().
get_hint(Secret, Guess) ->
    SecretList = binary_to_list(Secret),
    GuessList = binary_to_list(Guess),
    {Bulls, SecretRest, GuessRest} = count_bulls(SecretList, GuessList, 0, [], []),
    Cows = count_cows(SecretRest, GuessRest, 0),
    list_to_binary(integer_to_list(Bulls) ++ "A" ++ integer_to_list(Cows) ++ "B").

count_bulls([], [], Bulls, SecretRest, GuessRest) ->
    {Bulls, lists:reverse(SecretRest), lists:reverse(GuessRest)};
count_bulls([S|Secret], [G|Guess], Bulls, SecretRest, GuessRest) ->
    if
        S =:= G -> count_bulls(Secret, Guess, Bulls + 1, SecretRest, GuessRest);
        true -> count_bulls(Secret, Guess, Bulls, [S|SecretRest], [G|GuessRest])
    end.

count_cows(SecretRest, GuessRest, Cows) ->
    SecretCount = count_chars(SecretRest, #{}),
    GuessCount = count_chars(GuessRest, #{}),
    maps:fold(fun(K, V, Acc) ->
        case maps:get(K, GuessCount, 0) of
            0 -> Acc;
            GuessV -> Acc + min(V, GuessV)
        end
    end, Cows, SecretCount).

count_chars([], Map) -> Map;
count_chars([H|T], Map) ->
    count_chars(T, maps:update_with(H, fun(V) -> V + 1 end, 1, Map)).