-spec sum_of_three(Num :: integer()) -> [integer()] | [] .
sum_of_three(Num) ->
    case Num rem 3 of
        0 ->
            X = Num div 3,
            [X - 1, X, X + 1];
        _ ->
            []
    end.