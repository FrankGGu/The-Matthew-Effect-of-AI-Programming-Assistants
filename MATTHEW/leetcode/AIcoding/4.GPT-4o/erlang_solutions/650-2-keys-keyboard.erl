-module(solution).
-export([min_steps/1]).

min_steps(N) when N < 1 -> 0;
min_steps(N) -> min_steps_helper(N, 1, 0).

min_steps_helper(1, _, Steps) -> Steps;
min_steps_helper(N, Current, Steps) ->
    case N rem Current of
        0 -> 
            min_steps_helper(N div Current, Current, Steps + 1);
        _ -> 
            min_steps_helper(N, Current + 1, Steps + 1)
    end.