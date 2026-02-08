-module(solution).
-export([grid_illumination/3]).

grid_illumination(N, Lamps, Queries) ->
    LampsMap = lists:foldl(fun({X, Y}, Acc) -> maps:update_with({X, Y}, fun(_) -> 1 end, fun(_) -> 1 end, Acc) end, maps:new(), Lamps),
    Rows = maps:new(),
    Cols = maps:new(),
    Diags1 = maps:new(),
    Diags2 = maps:new(),
    {Rows, Cols, Diags1, Diags2} = lists:foldl(fun({X, Y}, {R, C, D1, D2}) -> 
        {maps:update_with(X, fun(_) -> 1 end, fun(_) -> 1 end, R), 
         maps:update_with(Y, fun(_) -> 1 end, fun(_) -> 1 end, C), 
         maps:update_with(X - Y, fun(_) -> 1 end, fun(_) -> 1 end, D1), 
         maps:update_with(X + Y, fun(_) -> 1 end, fun(_) -> 1 end, D2)} 
    end, {Rows, Cols, Diags1, Diags2}, Lamps),

    lists:map(fun({X, Y}) -> 
        if maps:get(X, Rows, 0) > 0 orelse maps:get(Y, Cols, 0) > 0 orelse maps:get(X - Y, Diags1, 0) > 0 orelse maps:get(X + Y, Diags2, 0) > 0 
        then 1 
        else 0 
        end 
    end, Queries).