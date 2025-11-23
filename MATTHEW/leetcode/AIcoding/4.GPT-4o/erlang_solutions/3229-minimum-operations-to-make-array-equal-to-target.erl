-module(solution).
-export([min_operations/2]).

min_operations(Target, n) ->
    Total = n * (n + 1) div 2,
    AbsDiff = abs(Total - Target),
    if 
        AbsDiff rem 2 =:= 0 -> 
            AbsDiff div 2; 
        true -> 
            AbsDiff div 2 + 1 
    end.