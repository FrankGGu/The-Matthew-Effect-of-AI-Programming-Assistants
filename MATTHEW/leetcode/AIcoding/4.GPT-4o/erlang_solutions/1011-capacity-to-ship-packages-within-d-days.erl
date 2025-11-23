-module(solution).
-export([ship_within_days/2]).

ship_within_days(Weights, D) ->
    MinCapacity = lists:max(Weights),
    MaxCapacity = lists:sum(Weights),
    bin_search(MinCapacity, MaxCapacity, Weights, D).

bin_search(Low, High, Weights, D) when Low < High ->
    Mid = (Low + High) div 2,
    case can_ship(Weights, Mid, D) of
        true -> bin_search(Low, Mid, Weights, D);
        false -> bin_search(Mid + 1, High, Weights, D)
    end;
bin_search(Low, High, _, _) -> Low.

can_ship(Weights, Capacity, D) ->
    Total = 0,
    Days = 1,
    lists:all(fun(W) ->
        case Total + W > Capacity of
            true ->
                Days = Days + 1,
                Total = W;
            false ->
                Total = Total + W
        end,
        Days =< D
    end, Weights).