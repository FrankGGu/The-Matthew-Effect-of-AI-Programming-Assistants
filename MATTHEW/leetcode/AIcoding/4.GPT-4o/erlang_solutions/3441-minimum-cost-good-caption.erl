-module(solution).
-export([min_cost/2]).

min_cost(Captions, Cost) ->
    MinCost = lists:min(Cost),
    TotalCost = lists:sum(Cost),
    GoodCaptions = lists:filter(fun(Caption) -> Caption > MinCost end, Captions),
    case GoodCaptions of
        [] -> TotalCost;
        _ -> lists:sum(lists:map(fun(Caption) -> Caption - MinCost end, GoodCaptions))
    end.