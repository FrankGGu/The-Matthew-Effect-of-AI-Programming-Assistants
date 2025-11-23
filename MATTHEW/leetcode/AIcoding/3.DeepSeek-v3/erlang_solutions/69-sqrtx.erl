-spec my_sqrt(X :: integer()) -> integer().
my_sqrt(X) ->
    my_sqrt_helper(X, 0, X).

my_sqrt_helper(X, Low, High) ->
    Mid = Low + (High - Low) div 2,
    case Mid * Mid > X of
        true -> my_sqrt_helper(X, Low, Mid - 1);
        false ->
            case (Mid + 1) * (Mid + 1) > X of
                true -> Mid;
                false -> my_sqrt_helper(X, Mid + 1, High)
            end
    end.