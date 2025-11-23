-spec find_repeated_dna_sequences(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
find_repeated_dna_sequences(S) ->
    case byte_size(S) of
        Len when Len < 10 -> [];
        _ -> 
            find_repeated_dna_sequences(S, #{}, 0, #{})
    end.

find_repeated_dna_sequences(S, Map, Index, Result) when Index + 10 > byte_size(S) ->
    maps:keys(Result);
find_repeated_dna_sequences(S, Map, Index, Result) ->
    Sub = binary:part(S, Index, 10),
    case maps:get(Sub, Map, 0) of
        1 -> 
            find_repeated_dna_sequences(S, Map#{Sub => 2}, Index + 1, Result#{Sub => true});
        N -> 
            find_repeated_dna_sequences(S, Map#{Sub => N + 1}, Index + 1, Result)
    end.