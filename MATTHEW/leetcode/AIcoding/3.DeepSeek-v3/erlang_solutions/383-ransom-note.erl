-spec can_construct(RansomNote :: unicode:unicode_binary(), Magazine :: unicode:unicode_binary()) -> boolean().
can_construct(RansomNote, Magazine) ->
    NoteCount = count_chars(RansomNote),
    MagCount = count_chars(Magazine),
    can_construct(NoteCount, MagCount).

count_chars(String) ->
    count_chars(String, #{}).

count_chars(<<>>, Count) -> Count;
count_chars(<<Char/utf8, Rest/binary>>, Count) ->
    NewCount = maps:update_with(Char, fun(V) -> V + 1 end, 1, Count),
    count_chars(Rest, NewCount).

can_construct(NoteCount, MagCount) ->
    maps:fold(
        fun(Char, Count, Acc) ->
            case maps:get(Char, MagCount, 0) of
                MagCount when MagCount >= Count -> Acc;
                _ -> false
            end
        end,
        true,
        NoteCount
    ).