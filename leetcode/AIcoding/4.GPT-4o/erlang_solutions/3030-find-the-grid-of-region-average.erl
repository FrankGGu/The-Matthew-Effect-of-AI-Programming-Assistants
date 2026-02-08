-module(solution).
-export([region_average/1]).

region_average(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    lists:map(fun(R) -> lists:map(fun(C) -> region_sum(Grid, R, C) / region_count(Grid, R, C) end) end, lists:seq(1, Rows)).

region_sum(Grid, R, C) ->
    lists:foldl(fun({R1, C1}, Acc) -> 
        if 
            R1 >= 1, R1 =< length(Grid), 
            C1 >= 1, C1 =< length(hd(Grid)) -> 
                Acc + lists:nth(C1, lists:nth(R1, Grid))
            ; 
                Acc 
        end 
    end, 0, neighbors(R, C)).

region_count(Grid, R, C) ->
    lists:foldl(fun({R1, C1}, Acc) -> 
        if 
            R1 >= 1, R1 =< length(Grid), 
            C1 >= 1, C1 =< length(hd(Grid)) -> 
                Acc + 1 
            ; 
                Acc 
        end 
    end, 0, neighbors(R, C)).

neighbors(R, C) ->
    [{R + 1, C}, {R - 1, C}, {R, C + 1}, {R, C - 1}].