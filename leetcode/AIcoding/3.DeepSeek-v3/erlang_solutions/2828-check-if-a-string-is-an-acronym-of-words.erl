-spec is_acronym(Words :: [unicode:unicode_binary()], S :: unicode:unicode_binary()) -> boolean().
is_acronym(Words, S) ->
    case Words of
        [] -> S =:= <<>>;
        _ ->
            case S of
                <<>> -> false;
                _ ->
                    FirstLetters = lists:map(fun(Word) -> 
                        case Word of
                            <<First:8, _/binary>> -> First;
                            _ -> 0
                        end
                    end, Words),
                    Acronym = list_to_binary(FirstLetters),
                    Acronym =:= S
            end
    end.