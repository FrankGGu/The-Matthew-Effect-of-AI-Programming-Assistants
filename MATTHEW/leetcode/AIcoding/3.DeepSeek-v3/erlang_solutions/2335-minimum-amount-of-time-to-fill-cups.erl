-spec fill_cups(Amount :: [integer()]) -> integer().
fill_cups(Amount) ->
    [A, B, C] = lists:sort(fun(X, Y) -> X >= Y end, Amount),
    case A >= B + C of
        true -> A;
        false -> (A + B + C + 1) div 2
    end.