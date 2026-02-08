-module(ship_within_days).
-export([shipWithinDays/2]).

shipWithinDays(Weights, D) ->
    MaxWeight = lists:max(Weights),
    TotalWeight = lists:sum(Weights),
    binarySearch(MaxWeight, TotalWeight, Weights, D).

binarySearch(Left, Right, Weights, D) ->
    case Left > Right of
        true ->
            Left;
        false ->
            Mid = (Left + Right) div 2,
            case isPossible(Weights, D, Mid) of
                true ->
                    binarySearch(Left, Mid - 1, Weights, D);
                false ->
                    binarySearch(Mid + 1, Right, Weights, D)
            end
    end.

isPossible(Weights, D, Capacity) ->
    {Result, _} = lists:foldl(fun(Weight, {Count, CurrentCapacity}) ->
                                        case CurrentCapacity + Weight =< Capacity of
                                            true ->
                                                {Count, CurrentCapacity + Weight};
                                            false ->
                                                {Count + 1, Weight}
                                        end
                                end, {1, 0}, Weights),
    Result =< D.