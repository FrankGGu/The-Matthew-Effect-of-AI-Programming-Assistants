-spec check_distances(S :: unicode:unicode_binary(), Distance :: [integer()]) -> boolean().
check_distances(S, Distance) ->
    SList = unicode:characters_to_list(S),
    check_distances(SList, Distance, 0, #{}).

check_distances([], _, _, _) -> true;
check_distances([Char | Rest], Distance, Index, Map) ->
    case maps:find(Char, Map) of
        {ok, PrevIndex} ->
            ExpectedDistance = lists:nth(Char - $a + 1, Distance),
            if
                Index - PrevIndex - 1 =:= ExpectedDistance ->
                    check_distances(Rest, Distance, Index + 1, Map);
                true ->
                    false
            end;
        error ->
            check_distances(Rest, Distance, Index + 1, Map#{Char => Index})
    end.