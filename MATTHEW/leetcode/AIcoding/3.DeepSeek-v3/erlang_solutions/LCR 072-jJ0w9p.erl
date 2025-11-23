-spec my_sqrt(X :: integer()) -> integer().
my_sqrt(X) ->
    if
        X == 0 -> 0;
        X == 1 -> 1;
        true -> binary_search(X, 1, X)
    end.

binary_search(X, Left, Right) ->
    Mid = Left + (Right - Left) div 2,
    if
        Mid =< X div Mid andalso (Mid + 1) > X div (Mid + 1) -> Mid;
        Mid > X div Mid -> binary_search(X, Left, Mid - 1);
        true -> binary_search(X, Mid + 1, Right)
    end.