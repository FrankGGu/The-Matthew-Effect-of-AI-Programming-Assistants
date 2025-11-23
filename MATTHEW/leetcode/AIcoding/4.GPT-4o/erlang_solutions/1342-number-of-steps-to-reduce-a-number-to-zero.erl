-module(solution).
-export([number_of_steps/1]).

number_of_steps(N) when N >= 0 ->
    number_of_steps_helper(N, 0).

number_of_steps_helper(0, Steps) -> 
    Steps;
number_of_steps_helper(N, Steps) ->
    case N rem 2 of
        0 -> number_of_steps_helper(N div 2, Steps + 1);
        _ -> number_of_steps_helper(N - 1, Steps + 1)
    end.