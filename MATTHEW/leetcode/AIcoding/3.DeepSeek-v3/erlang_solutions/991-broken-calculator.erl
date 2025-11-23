-spec broken_calc(X :: integer(), Y :: integer()) -> integer().
broken_calc(X, Y) when X >= Y ->
    X - Y;
broken_calc(X, Y) ->
    case Y rem 2 of
        0 -> 1 + broken_calc(X, Y div 2);
        1 -> 1 + broken_calc(X, Y + 1)
    end.