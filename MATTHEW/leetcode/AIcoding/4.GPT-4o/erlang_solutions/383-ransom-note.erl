-spec can_construct(RansomNote :: unicode:unicode_binary(), Magazine :: unicode:unicode_binary()) -> boolean().
can_construct(RansomNote, Magazine) ->
    can_construct(RansomNote, Magazine, dict:new()).

can_construct([], _, _) -> true;
can_construct(_, [], _) -> false;
can_construct([H|T], Magazine, Dict) ->
    case dict:find(H, Dict) of
        {ok, Count} when Count > 0 -> 
            NewDict = dict:store(H, Count - 1, Dict),
            can_construct(T, Magazine, NewDict);
        _ -> 
            case lists:prefix([H], Magazine) of
                true -> 
                    NewDict = dict:store(H, 1, Dict),
                    can_construct(T, tl(Magazine), NewDict);
                false -> 
                    false
            end
    end.
