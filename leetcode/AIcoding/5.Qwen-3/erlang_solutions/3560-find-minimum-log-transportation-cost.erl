-module(find_minimum_log_transportation_cost).
-export([min_cost/1]).

min_cost(Costs) ->
    min_cost(Costs, 0, 0, 0).

min_cost([], _, _, Min) ->
    Min;
min_cost([H | T], Index, Current, Min) ->
    NewCurrent = Current + H,
    NewMin = if
        NewCurrent < Min -> NewCurrent;
        true -> Min
    end,
    min_cost(T, Index + 1, NewCurrent, NewMin).