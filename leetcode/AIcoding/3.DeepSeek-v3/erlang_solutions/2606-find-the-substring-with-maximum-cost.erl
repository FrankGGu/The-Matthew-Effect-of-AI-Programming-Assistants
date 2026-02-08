-spec max_sub_array_sum(Values :: [integer()], S :: unicode:unicode_binary()) -> integer().
max_sub_array_sum(Values, S) ->
    Chars = unicode:characters_to_list(S),
    MaxCost = lists:foldl(fun(Char, {CurrentMax, GlobalMax}) ->
        Value = lists:nth(Char - $a + 1, Values),
        NewCurrentMax = max(Value, CurrentMax + Value),
        NewGlobalMax = max(NewCurrentMax, GlobalMax),
        {NewCurrentMax, NewGlobalMax}
    end, {0, -16#80000000}, Chars),
    element(2, MaxCost).