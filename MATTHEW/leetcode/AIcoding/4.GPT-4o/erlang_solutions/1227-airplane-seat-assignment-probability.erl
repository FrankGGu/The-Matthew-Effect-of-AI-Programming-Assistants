-module(solution).
-export([nth_seat_probability/1]).

nth_seat_probability(N) ->
    case N of
        1 -> 1.0;
        2 -> 0.5;
        _ -> 1.0 / (2 * (N - 1))
    end.