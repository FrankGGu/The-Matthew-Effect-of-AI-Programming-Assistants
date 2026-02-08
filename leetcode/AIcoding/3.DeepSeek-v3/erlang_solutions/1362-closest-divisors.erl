-spec closest_divisors(Num :: integer()) -> [integer()].
closest_divisors(Num) ->
    D1 = find_divisors(Num + 1),
    D2 = find_divisors(Num + 2),
    case abs(element(1, D1) - element(2, D1)) =< abs(element(1, D2) - element(2, D2)) of
        true -> [element(1, D1), element(2, D1)];
        false -> [element(1, D2), element(2, D2)]
    end.

find_divisors(N) ->
    find_divisors(N, trunc(math:sqrt(N)), N).

find_divisors(N, I, MinDiff) when I > 0 ->
    case N rem I of
        0 -> {I, N div I};
        _ -> find_divisors(N, I - 1, MinDiff)
    end;
find_divisors(_, _, _) -> {1, N}.