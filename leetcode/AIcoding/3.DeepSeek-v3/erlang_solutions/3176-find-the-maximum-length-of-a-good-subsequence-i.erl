-spec maximum_length(Nums :: [integer()], K :: integer()) -> integer().
maximum_length(Nums, K) ->
    {_, Ans} = lists:foldl(fun(Num, {Map, MaxLen}) ->
        NewMap = maps:fold(fun(Key, Val, Acc) ->
            Diff = abs(Key - Num),
            if
                Diff =< K -> maps:put(Key, Val + 1, Acc);
                true -> Acc
            end
        end, #{Num => 1}, Map),
        CurrentMax = case maps:values(NewMap) of
            [] -> 0;
            Vals -> lists:max(Vals)
        end,
        {NewMap, max(MaxLen, CurrentMax)}
    end, {#{}, 0}, Nums),
    Ans.