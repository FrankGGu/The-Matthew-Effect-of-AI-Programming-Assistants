-spec min_steps(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
min_steps(S, T) ->
    CountS = count_chars(S),
    CountT = count_chars(T),
    AllKeys = lists:usort(maps:keys(CountS) ++ maps:keys(CountT)),
    lists:foldl(fun(Key, Acc) ->
                    Acc + abs(maps:get(Key, CountS, 0) - maps:get(Key, CountT, 0))
                end, 0, AllKeys).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
                    maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                end, #{}, unicode:characters_to_list(Str)).