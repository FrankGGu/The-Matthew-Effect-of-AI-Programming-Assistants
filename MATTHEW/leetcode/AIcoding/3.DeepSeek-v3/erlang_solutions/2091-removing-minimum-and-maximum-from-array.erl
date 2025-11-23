-spec delete_min_max(Arr :: [integer()]) -> integer().
delete_min_max(Arr) ->
    Min = lists:min(Arr),
    Max = lists:max(Arr),
    {MinIndex, _} = lists:foldl(fun(X, {Index, CurrentIndex}) ->
                                    if X == Min -> {CurrentIndex, CurrentIndex + 1};
                                       true -> {Index, CurrentIndex + 1}
                                    end
                                end, {-1, 0}, Arr),
    {MaxIndex, _} = lists:foldl(fun(X, {Index, CurrentIndex}) ->
                                    if X == Max -> {CurrentIndex, CurrentIndex + 1};
                                       true -> {Index, CurrentIndex + 1}
                                    end
                                end, {-1, 0}, Arr),
    {Left, Right} = if MinIndex < MaxIndex -> {MinIndex, MaxIndex};
                       true -> {MaxIndex, MinIndex}
                    end,
    Option1 = Right + 1,
    Option2 = length(Arr) - Left,
    Option3 = (Left + 1) + (length(Arr) - Right),
    lists:min([Option1, Option2, Option3]).