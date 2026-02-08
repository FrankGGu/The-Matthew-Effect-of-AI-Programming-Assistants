-module(solution).
-export([min_steps/2]).

min_steps(N, A) when N > 0 ->
    min_steps_helper(N, A, 0, 0).

min_steps_helper(0, _, Steps, _) -> Steps;
min_steps_helper(N, A, Steps, _Visited) ->
    lists:min(
        [min_steps_helper(N - Step, A, Steps + 1, Step) || Step <- A, Step =< N]
    ).