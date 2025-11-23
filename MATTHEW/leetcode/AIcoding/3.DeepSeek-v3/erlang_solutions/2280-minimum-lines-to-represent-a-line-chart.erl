-spec minimum_lines(Prices :: [[integer()]]) -> integer().
minimum_lines(Prices) ->
    case length(Prices) of
        0 -> 0;
        1 -> 0;
        _ ->
            Sorted = lists:sort(fun([X1, _], [X2, _]) -> X1 =< X2 end, Prices),
            calculate_lines(Sorted)
    end.

calculate_lines([_]) -> 0;
calculate_lines([P1, P2 | Rest]) ->
    Lines = calculate_lines([P2 | Rest]),
    case Rest of
        [] -> 1;
        [P3 | _] ->
            [X1, Y1] = P1,
            [X2, Y2] = P2,
            [X3, Y3] = P3,
            case (Y2 - Y1) * (X3 - X2) == (Y3 - Y2) * (X2 - X1) of
                true -> Lines;
                false -> Lines + 1
            end
    end.