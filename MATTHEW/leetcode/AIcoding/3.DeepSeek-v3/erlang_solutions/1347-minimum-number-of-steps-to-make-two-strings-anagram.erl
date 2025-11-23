-spec min_steps(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
min_steps(S, T) ->
    SCount = count_chars(S),
    TCount = count_chars(T),
    lists:sum([max(0, maps:get(Char, SCount, 0) - maps:get(Char, TCount, 0) || Char <- maps:keys(SCount)]).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) 
    end, #{}, unicode:characters_to_list(Str)).