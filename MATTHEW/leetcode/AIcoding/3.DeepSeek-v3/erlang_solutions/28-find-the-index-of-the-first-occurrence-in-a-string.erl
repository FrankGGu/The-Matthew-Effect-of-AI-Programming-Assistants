-spec str_str(Haystack :: unicode:unicode_binary(), Needle :: unicode:unicode_binary()) -> integer().
str_str(Haystack, Needle) ->
    case binary:match(Haystack, Needle) of
        {Pos, _} -> Pos;
        nomatch -> -1
    end.