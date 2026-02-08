-module(rearranging_fruits).
-export([min_cost/1]).

min_cost(Fruits) ->
    min_cost(Fruits, []).

min_cost([], Acc) ->
    case length(Acc) rem 2 == 0 of
        true -> 0;
        false ->
            lists:min(Acc) div 2
    end;
min_cost([F | Rest], Acc) ->
    case lists:member(F, Rest) of
        true ->
            Rest2 = lists:delete(F, Rest);
            min_cost(Rest2, Acc);
        false ->
            min_cost(Rest, [F | Acc])
    end.