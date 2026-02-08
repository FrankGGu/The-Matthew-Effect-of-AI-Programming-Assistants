-module(solution).
-export([number_of_steps/1]).

number_of_steps(N) when N > 0 ->
    number_of_steps(N, 0).

number_of_steps(1, Steps) ->
    Steps;
number_of_steps(N, Steps) ->
    if
        N rem 2 == 0 ->
            number_of_steps(N div 2, Steps + 1);
        true ->
            number_of_steps(N - 1, Steps + 1)
    end.