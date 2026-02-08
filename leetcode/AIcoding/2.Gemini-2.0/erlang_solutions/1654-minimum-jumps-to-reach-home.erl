-module(minimum_jumps).
-export([minimumJumps/3]).

minimumJumps(Forbidden, A, B, X) ->
    MaxRange = X + A + B + lists:max(Forbidden),
    ForbiddenSet = sets:from_list(Forbidden),
    Q = queue:new(),
    queue:in({0, 0, false}, Q),
    Visited = sets:new(),
    sets:add({0, false}, Visited),
    minimumJumpsHelper(ForbiddenSet, A, B, X, Q, Visited, MaxRange, 0).

minimumJumpsHelper(ForbiddenSet, A, B, X, Q, Visited, MaxRange, Steps) ->
    case queue:is_empty(Q) of
        true -> -1;
        false ->
            {{value, {Pos, LastBack, Back}}, Q1} = queue:out(Q),
            case Pos =:= X of
                true -> Steps;
                false ->
                    NewSteps = Steps + 1,
                    {NewQ, NewVisited} =
                        lists:foldl(
                            fun({NewPos, NewBack}, {AccQ, AccVisited}) ->
                                case NewPos < 0 orelse NewPos > 2 * MaxRange orelse sets:is_element(NewPos, ForbiddenSet) orelse sets:is_element({NewPos, NewBack}, AccVisited) of
                                    true -> {AccQ, AccVisited};
                                    false ->
                                        NewAccVisited = sets:add({NewPos, NewBack}, AccVisited),
                                        {queue:in({NewPos, NewSteps, NewBack}, AccQ), NewAccVisited}
                                end
                            end,
                            {Q1, Visited},
                            [{Pos + A, false},
                             case LastBack of
                                 false -> {Pos - B, true};
                                 true -> {Pos - B, true} % Dummy entry
                             end]
                        ),
                    minimumJumpsHelper(ForbiddenSet, A, B, X, NewQ, NewVisited, MaxRange, NewSteps)
            end
    end.