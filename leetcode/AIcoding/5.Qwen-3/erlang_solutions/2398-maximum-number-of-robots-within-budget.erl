-module(maximum_number_of_robots_within_budget).
-export([maximumRobots/2]).

maximumRobots(RobotCosts, Budget) ->
    maximumRobots(RobotCosts, Budget, 0, 0, 0).

maximumRobots([], _Budget, _Total, _Count, _Max) ->
    _Max;
maximumRobots([Cost | Rest], Budget, Total, Count, Max) ->
    case Total + Cost of
        NewTotal when NewTotal =< Budget ->
            maximumRobots(Rest, Budget, NewTotal, Count + 1, max(Max, Count + 1));
        _ ->
            maximumRobots(Rest, Budget, Total, Count, Max)
    end.