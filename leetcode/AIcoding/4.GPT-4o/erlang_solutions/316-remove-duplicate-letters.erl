-spec remove_duplicate_letters(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_duplicate_letters(S) ->
    remove_duplicate_letters(S, <<>>, []).

remove_duplicate_letters(<<>>, _, _) -> <<>>;
remove_duplicate_letters(<<H:8, T/binary>>, Result, Seen) when not lists:member(H, Seen) ->
    remove_duplicate_letters(T, <<Result/binary, H:8>>, [H | Seen]);
remove_duplicate_letters(<<_H:8, T/binary>>, Result, Seen) ->
    remove_duplicate_letters(T, Result, Seen).
