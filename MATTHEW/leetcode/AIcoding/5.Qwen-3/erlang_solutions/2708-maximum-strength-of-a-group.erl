-module(maximum_strength).
-export([maxStrength/1]).

maxStrength(Numbers) ->
    maxStrength(Numbers, 0, 0, 0).

maxStrength([], Min, Max, Product) ->
    case {Min, Max} of
        {0, 0} -> 0;
        _ -> Product
    end;

maxStrength([N | Rest], Min, Max, Product) ->
    NewMin = min(Min, N),
    NewMax = max(Max, N),
    NewProduct = Product * N,
    maxStrength(Rest, NewMin, NewMax, NewProduct).