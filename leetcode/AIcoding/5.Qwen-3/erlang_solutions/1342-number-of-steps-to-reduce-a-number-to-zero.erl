-module(solution).
-export([num_steps/1]).

num_steps(N) ->
    num_steps(N, 0).

num_steps(0, Steps) ->
    Steps;
num_steps(N, Steps) ->
    if
        N rem 2 == 0 ->
            num_steps(N div 2, Steps + 1);
        true ->
            num_steps(N - 1, Steps + 1)
    end.