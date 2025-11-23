-module(e204).
-export([min_steps/1]).

min_steps(N) ->
    min_steps(N, 2, 0).

min_steps(1, _, Acc) ->
    Acc;
min_steps(N, Div, Acc) ->
    case N rem Div of
        0 ->
            min_steps(N div Div, Div, Acc + Div);
        _ ->
            min_steps(N, Div + 1, Acc)
    end.