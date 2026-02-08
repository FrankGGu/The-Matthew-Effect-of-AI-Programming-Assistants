-module(solution).
-export([robotCollisions/3]).

robotCollisions(Positions, Healths, Directions) ->
    RobotsWithId = lists:zip3(Positions, Healths, Directions),
    IndexedRobots = lists:mapi(fun(Idx, {Pos, H, Dir}) ->
                                     #{id => Idx, pos => Pos, health => H, dir => Dir}
                             end, lists:seq(0, length(Positions) - 1), RobotsWithId),
    SortedRobots = lists:sort(fun(R1, R2) -> R1#{pos} < R2#{pos} end, IndexedRobots),

    FinalStack = simulate_collisions(SortedRobots, []),

    SortedSurvivors = lists:sort(fun(R1, R2) -> R1#{id} < R2#{id} end, FinalStack),
    lists:map(fun(R) -> R#{health} end, SortedSurvivors).

simulate_collisions([], Stack) ->
    Stack;
simulate_collisions([Robot | RestRobots], Stack) ->
    Dir = Robot#{dir},
    case Dir of
        'R' ->
            simulate_collisions(RestRobots, [Robot | Stack]);
        'L' ->
            {UpdatedLRobot, NewStack} = collide_l_robot(Robot, Stack),
            case UpdatedLRobot of
                null ->
                    simulate_collisions(RestRobots, NewStack);
                _ ->
                    simulate_collisions(RestRobots, [UpdatedLRobot | NewStack])
            end
    end.

collide_l_robot(LRobot, []) ->
    {LRobot, []};
collide_l_robot(LRobot, [RRobot | StackTail]) ->
    case RRobot#{dir} of
        'R' ->
            LHealth = LRobot#{health},
            RHealth = RRobot#{health},
            case {LHealth > RHealth, LHealth < RHealth} of
                {true, false} ->
                    NewLRobot = LRobot#{health := LHealth - 1},
                    collide_l_robot(NewLRobot, StackTail);
                {false, true} ->
                    NewRRobot = RRobot#{health := RHealth - 1},
                    {null, [NewRRobot | StackTail]};
                {false, false} ->
                    {null, StackTail}
            end;
        'L' ->
            {LRobot, [RRobot | StackTail]}
    end.