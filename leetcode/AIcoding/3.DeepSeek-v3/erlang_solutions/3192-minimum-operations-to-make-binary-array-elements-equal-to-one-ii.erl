-spec min_operations(Binary :: [integer()]) -> integer().
min_operations(Binary) ->
    min_operations(Binary, 0, 0).

min_operations([], Flips, Ans) ->
    Ans;
min_operations([H | T], Flips, Ans) ->
    Current = (H + Flips) rem 2,
    if
        Current == 0 ->
            min_operations(T, Flips + 1, Ans + 1);
        true ->
            min_operations(T, Flips, Ans)
    end.