-spec max_array(Arr :: [integer()]) -> integer().
max_array(Arr) ->
    lists:foldl(fun(X, Acc) -> max(X, Acc) end, hd(Arr), Arr).