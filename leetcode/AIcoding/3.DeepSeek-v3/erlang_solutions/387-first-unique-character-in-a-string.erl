-spec first_uniq_char(S :: unicode:unicode_binary()) -> integer().
first_uniq_char(S) ->
    Counts = lists:foldl(fun(Char, Acc) -> 
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, unicode:characters_to_list(S)),
    find_first_unique(unicode:characters_to_list(S), Counts, 0).

find_first_unique([], _, _)
    -> -1;
find_first_unique([Char | Rest], Counts, Index) ->
    case maps:get(Char, Counts) of
        1 -> Index;
        _ -> find_first_unique(Rest, Counts, Index + 1)
    end.