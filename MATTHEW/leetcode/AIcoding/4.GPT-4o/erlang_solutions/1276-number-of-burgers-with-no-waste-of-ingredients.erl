-module(solution).
-export([numOfBurgers/2]).

numOfBurgers(0, 0) ->
    [0, 0];
numOfBurgers(Tomatoes, Cheese) when Tomatoes rem 2 =:= 0, Cheese rem 1 =:= 0 ->
    let
        Total = Tomatoes + Cheese,
        C1 = (Total - 2 * Cheese) div 2,
        C2 = Cheese - C1
    in
        if C1 >= 0, C2 >= 0, C1 + C2 * 2 =:= Tomatoes + Cheese -> 
            [C1, C2];
        true ->
            []
        end
    end;
numOfBurgers(_, _) ->
    [].