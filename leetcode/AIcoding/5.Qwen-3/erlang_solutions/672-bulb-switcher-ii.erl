-module(bulb_switcher_ii).
-export([num_turn_on/1]).

num_turn_on(N) ->
    num_turn_on(N, 0, 0).

num_turn_on(0, _, _) ->
    0;
num_turn_on(N, A, B) ->
    case (A + B) rem 2 of
        0 ->
            num_turn_on(N - 1, A + 1, B);
        _ ->
            num_turn_on(N - 1, A, B + 1)
    end.