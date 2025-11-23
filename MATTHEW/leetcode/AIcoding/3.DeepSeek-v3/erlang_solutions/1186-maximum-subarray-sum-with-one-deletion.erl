-spec maximum_sum(Arr :: [integer()]) -> integer().
maximum_sum(Arr) ->
    {MaxNoDelete, MaxWithDelete} = lists:foldl(fun(X, {NoDelete, WithDelete}) ->
        NewNoDelete = max(X, NoDelete + X),
        NewWithDelete = max(WithDelete + X, NoDelete),
        {NewNoDelete, NewWithDelete}
    end, {hd(Arr), -1000000}, tl(Arr)),
    max(MaxNoDelete, MaxWithDelete).