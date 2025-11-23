-spec beautiful_array(N :: integer()) -> [integer()].
beautiful_array(1) -> [1];
beautiful_array(N) ->
    Left = beautiful_array((N + 1) div 2),
    Right = beautiful_array(N div 2),
    lists:append([lists:map(fun(X) -> 2 * X - 1 end, Left), lists:map(fun(X) -> 2 * X end, Right)]).