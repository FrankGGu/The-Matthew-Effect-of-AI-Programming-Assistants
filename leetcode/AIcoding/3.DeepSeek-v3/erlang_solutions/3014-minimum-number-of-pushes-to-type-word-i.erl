-spec minimum_pushes(Word :: unicode:unicode_binary()) -> integer().
minimum_pushes(Word) ->
    Chars = unicode:characters_to_list(Word),
    Counts = lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Chars),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, maps:to_list(Counts)),
    {Pushes, _} = lists:foldl(fun({_, C}, {Acc, Pos}) ->
        Pushes = ((Pos - 1) div 8 + 1) * C,
        {Acc + Pushes, Pos + 1}
    end, {0, 1}, Sorted),
    Pushes.