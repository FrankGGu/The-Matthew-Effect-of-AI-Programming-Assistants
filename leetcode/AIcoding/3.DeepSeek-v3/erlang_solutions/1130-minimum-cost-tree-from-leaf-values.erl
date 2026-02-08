-spec mct_from_leaf_values(Arr :: [integer()]) -> integer().
mct_from_leaf_values(Arr) ->
    Stack = [],
    Res = 0,
    mct_from_leaf_values(Arr, Stack, Res).

mct_from_leaf_values([], [X], Res) ->
    Res;
mct_from_leaf_values([], Stack, Res) ->
    [X, Y | Rest] = Stack,
    NewRes = Res + X * Y,
    NewStack = [min(X, Y) | Rest],
    mct_from_leaf_values([], NewStack, NewRes);
mct_from_leaf_values([H | T], Stack, Res) ->
    case Stack of
        [] -> mct_from_leaf_values(T, [H | Stack], Res);
        [Top | _] when H =< Top -> mct_from_leaf_values(T, [H | Stack], Res);
        [Top | Rest] ->
            NewRes = Res + Top * H,
            NewStack = [H | Rest],
            mct_from_leaf_values([H | T], NewStack, NewRes)
    end.