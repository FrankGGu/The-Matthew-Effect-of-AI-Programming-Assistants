-spec cal_points(Operations :: [unicode:unicode_binary()]) -> integer().
cal_points(Operations) ->
    lists:foldl(fun cal_points_fold/2, [], Operations).

cal_points_fold(<<"+">>, Stack) ->
    [X, Y | _] = Stack,
    [X + Y | Stack];
cal_points_fold(<<"D">>, Stack) ->
    [X | _] = Stack,
    [2 * X | Stack];
cal_points_fold(<<"C">>, Stack) ->
    [_ | Rest] = Stack,
    Rest;
cal_points_fold(Op, Stack) ->
    [binary_to_integer(Op) | Stack].