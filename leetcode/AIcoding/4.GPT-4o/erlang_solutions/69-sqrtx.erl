-spec my_sqrt(X :: integer()) -> integer().
my_sqrt(X) when X < 2 -> X;
my_sqrt(X) ->
    my_sqrt(X, 0, X).

-spec my_sqrt(X :: integer(), Low :: integer(), High :: integer()) -> integer().
my_sqrt(X, Low, High) when Low <= High ->
    Mid = (Low + High) div 2,
    Square = Mid * Mid,
    case Square of
        S when S =:= X -> Mid;
        S when S < X -> my_sqrt(X, Mid + 1, High);
        _ -> my_sqrt(X, Low, Mid - 1)
    end.
