-spec appeal_sum(S :: unicode:unicode_binary()) -> integer().
appeal_sum(S) ->
    List = unicode:characters_to_list(S),
    LastPos = maps:new(),
    {Sum, Total, _} = lists:foldl(fun(Char, {CurrentSum, CurrentTotal, LastPosMap}) ->
        Last = maps:get(Char, LastPosMap, -1),
        Added = CurrentSum + (length(List) - 1) - Last,
        NewTotal = CurrentTotal + Added,
        NewLastPos = maps:put(Char, length(List) - 1, LastPosMap),
        {Added, NewTotal, NewLastPos}
    end, {0, 0, LastPos}, lists:seq(0, length(List) - 1)),
    Total.