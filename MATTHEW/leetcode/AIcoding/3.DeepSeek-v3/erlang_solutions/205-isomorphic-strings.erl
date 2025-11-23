-spec is_isomorphic(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_isomorphic(S, T) ->
    SList = unicode:characters_to_list(S),
    TList = unicode:characters_to_list(T),
    case length(SList) =:= length(TList) of
        false -> false;
        true ->
            check_mapping(SList, TList, #{}, #{})
    end.

check_mapping([], [], _, _) -> true;
check_mapping([SChar | SRest], [TChar | TRest], SToT, TToS) ->
    case {maps:get(SChar, SToT, undefined), maps:get(TChar, TToS, undefined)} of
        {undefined, undefined} ->
            NewSToT = maps:put(SChar, TChar, SToT),
            NewTToS = maps:put(TChar, SChar, TToS),
            check_mapping(SRest, TRest, NewSToT, NewTToS);
        {TChar, SChar} ->
            check_mapping(SRest, TRest, SToT, TToS);
        _ ->
            false
    end.