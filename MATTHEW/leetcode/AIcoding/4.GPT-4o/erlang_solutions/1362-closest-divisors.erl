-module(solution).
-export([closest_divisors/1]).

closest_divisors(N) ->
    closest_divisor_helper(N + 1, N + 2).

closest_divisor_helper(N, M) ->
    case find_divisors(N, 1, {0, 0}) of
        {A, B} -> {A, B};
        _ -> closest_divisor_helper(N + 1, M)
    end.

find_divisors(N, I, {BestX, BestY}) when I * I > N -> {BestX, BestY};
find_divisors(N, I, {BestX, BestY}) ->
    if
        N rem I =:= 0 ->
            J = N div I,
            if
                abs(I - J) < abs(BestX - BestY) orelse (BestX == 0) ->
                    find_divisors(N, I + 1, {I, J});
                true ->
                    find_divisors(N, I + 1, {BestX, BestY})
            end;
        true ->
            find_divisors(N, I + 1, {BestX, BestY})
    end.