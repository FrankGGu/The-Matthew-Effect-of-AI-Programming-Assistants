-module(minimum_cost_to_cut_a_stick).
-export([cost/1]).

cost(Cuts) ->
    lists:sort(Cuts),
    cost(Cuts, [0, lists:last(Cuts)], 0).

cost([], _, Acc) ->
    Acc;
cost([Cut | Rest], [Prev | _] = Sides, Acc) ->
    case lists:member(Cut, Sides) of
        true ->
            cost(Rest, Sides, Acc);
        false ->
            cost(Rest, [Cut | Sides], Acc + (lists:last(Sides) - Prev))
    end.