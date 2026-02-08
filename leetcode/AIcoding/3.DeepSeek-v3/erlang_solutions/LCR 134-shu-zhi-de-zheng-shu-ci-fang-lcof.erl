-spec my_pow(X :: float(), N :: integer()) -> float().
my_pow(X, N) ->
    case N of
        0 -> 1.0;
        1 -> X;
        -1 -> 1.0 / X;
        _ ->
            Half = my_pow(X, N div 2),
            case N rem 2 of
                0 -> Half * Half;
                1 when N > 0 -> Half * Half * X;
                -1 -> Half * Half / X
            end
    end.