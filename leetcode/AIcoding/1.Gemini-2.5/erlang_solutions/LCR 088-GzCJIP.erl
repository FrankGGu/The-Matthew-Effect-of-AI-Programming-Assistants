-module(solution).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Cost) ->
    % F1 represents the minimum cost to reach the current step.
    % F2 represents the minimum cost to reach the step before the current step.
    % Initial values F1=0, F2=0 signify that the cost to reach the positions
    % before the first two steps (index -1 and -2 conceptually) is zero,
    % as we can start from step 0 or step 1 without initial cost.
    {F1, F2} = lists:foldl(
        fun(C, {AccF1, AccF2}) ->
            % Calculate the minimum cost to reach the next step (NextF1)
            % by taking the current step 'C' and adding the minimum of
            % the costs to reach the previous two steps (AccF1 or AccF2).
            NextF1 = C + min(AccF1, AccF2),
            % The previous F1 becomes the new F2.
            NextF2 = AccF1,
            {NextF1, NextF2}
        end,
        {0, 0}, % Initial state: {F1, F2}
        Cost
    ),
    % After iterating through all costs, F1 holds the minimum cost to reach
    % the step immediately after the last element of Cost, and F2 holds
    % the minimum cost to reach the last element of Cost.
    % The problem asks for the minimum cost to reach the "top of the floor",
    % which is effectively one step beyond the last element.
    % Therefore, the answer is the minimum of F1 and F2.
    min(F1, F2).