-spec find_repeated_dna_sequences(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].

find_repeated_dna_sequences(S) ->
    find_repeated_dna_sequences(S, [], #{}).

find_repeated_dna_sequences([], Acc, _) -> lists:reverse(Acc);
find_repeated_dna_sequences(S, Acc, Seen) ->
    case lists:split(10, S) of
        {SubStr, Rest} when byte_size(SubStr) == 10 ->
            case maps:find(SubStr, Seen) of
                {ok, _} -> find_repeated_dna_sequences(Rest, [SubStr | Acc], Seen);
                error -> find_repeated_dna_sequences(Rest, Acc, maps:put(SubStr, true, Seen))
            end;
        _ -> lists:reverse(Acc)
    end.
