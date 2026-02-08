-spec find_repeated_dna_sequences(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
find_repeated_dna_sequences(S) ->
    case byte_size(S) of
        Len when Len < 11 ->
            [];
        _ ->
            find_repeated_dna_sequences(S, #{}, 0, #{})
    end.

find_repeated_dna_sequences(S, Seen, Index, Result) when Index + 10 =< byte_size(S) ->
    Sub = binary:part(S, Index, 10),
    case maps:get(Sub, Seen, 0) of
        1 ->
            find_repeated_dna_sequences(S, maps:put(Sub, 2, Seen), Index + 1, maps:put(Sub, true, Result));
        N ->
            find_repeated_dna_sequences(S, maps:put(Sub, N + 1, Seen), Index + 1, Result)
    end;
find_repeated_dna_sequences(_S, _Seen, _Index, Result) ->
    maps:keys(Result).