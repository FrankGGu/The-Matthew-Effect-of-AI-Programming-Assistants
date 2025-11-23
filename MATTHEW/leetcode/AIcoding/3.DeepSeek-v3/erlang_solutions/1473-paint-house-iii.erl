-module(solution).
-export([min_cost/5]).

min_cost(Houses, Cost, M, N, Target) ->
    DP = maps:new(),
    {Result, _} = helper(Houses, Cost, M, N, Target, 0, 0, 0, DP),
    case Result of
        infinity -> -1;
        _ -> Result
    end.

helper(Houses, Cost, M, N, Target, Pos, PrevColor, Neighborhoods, DP) ->
    case maps:find({Pos, PrevColor, Neighborhoods}, DP) of
        {ok, Value} ->
            {Value, DP};
        error ->
            if
                Pos =:= M ->
                    if
                        Neighborhoods =:= Target -> {0, DP};
                        true -> {infinity, DP}
                    end;
                true ->
                    CurrentColor = lists:nth(Pos + 1, Houses),
                    if
                        CurrentColor =/= 0 ->
                            NewNeighborhoods = if
                                CurrentColor =:= PrevColor -> Neighborhoods;
                                true -> Neighborhoods + 1
                            end,
                            if
                                NewNeighborhoods > Target -> {infinity, DP};
                                true ->
                                    {Res, NewDP} = helper(Houses, Cost, M, N, Target, Pos + 1, CurrentColor, NewNeighborhoods, DP),
                                    {Res, maps:put({Pos, PrevColor, Neighborhoods}, Res, NewDP)}
                            end;
                        true ->
                            MinCost = lists:foldl(fun(Color, Acc) ->
                                NewNeighborhoods = if
                                    Color =:= PrevColor -> Neighborhoods;
                                    true -> Neighborhoods + 1
                                end,
                                if
                                    NewNeighborhoods > Target -> Acc;
                                    true ->
                                        {Res, NewDP} = helper(Houses, Cost, M, N, Target, Pos + 1, Color, NewNeighborhoods, DP),
                                        CostVal = lists:nth(Pos + 1, lists:nth(Color, Cost)) + Res,
                                        min(Acc, CostVal)
                                end
                            end, infinity, lists:seq(1, N)),
                            {MinCost, maps:put({Pos, PrevColor, Neighborhoods}, MinCost, DP)}
                    end
            end
    end.