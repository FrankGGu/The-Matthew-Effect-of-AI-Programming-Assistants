-spec rearrange_characters(S :: unicode:unicode_binary(), Target :: unicode:unicode_binary()) -> integer().
rearrange_characters(S, Target) ->
    SCount = count_chars(S),
    TargetCount = count_chars(Target),
    lists:min([maps:get(Char, SCount, 0) div maps:get(Char, TargetCount, 1) || Char <- maps:keys(TargetCount)]).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) end, #{}, Str).