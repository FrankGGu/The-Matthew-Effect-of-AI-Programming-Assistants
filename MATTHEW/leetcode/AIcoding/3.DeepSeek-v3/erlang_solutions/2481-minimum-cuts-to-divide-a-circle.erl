-spec number_of_cuts(N :: integer()) -> integer().
number_of_cuts(N) ->
    case N of
        1 -> 0;
        _ when N rem 2 =:= 0 -> N div 2;
        _ -> N
    end.