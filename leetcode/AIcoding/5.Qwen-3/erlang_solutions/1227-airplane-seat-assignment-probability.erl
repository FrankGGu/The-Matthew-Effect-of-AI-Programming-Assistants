-module(probability_airplane_seat).
-export([k_n_people_getting_correct_seat/1]).

k_n_people_getting_correct_seat(N) ->
    case N of
        1 -> 1.0;
        _ -> 0.5
    end.