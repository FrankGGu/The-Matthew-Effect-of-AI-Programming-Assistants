-spec maximum_length(s :: unicode:unicode_binary()) -> integer().
maximum_length(S) ->
    Counts = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, unicode:characters_to_list(S)),
    case maps:size(Counts) of
        1 ->
            maps:fold(fun(_, V, Acc) -> max(Acc, V div 3) end, 0, Counts);
        _ ->
            lists:max([V || {_, V} <- maps:to_list(Counts)])
    end.