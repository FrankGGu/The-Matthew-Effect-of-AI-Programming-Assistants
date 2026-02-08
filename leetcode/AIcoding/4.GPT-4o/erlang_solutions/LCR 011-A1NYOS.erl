-module(solution).
-export([findMaxLength/1]).

findMaxLength(nums) ->
    mapfoldl(fun(X, {Sum, Map}) ->
        NewSum = Sum + (if X == 0 -> -1; true -> 1 end),
        case maps:is_key(NewSum, Map) of
            true -> {NewSum, Map};
            false -> {NewSum, maps:put(NewSum, maps:size(Map), Map)}
        end
    end, {0, maps:from_list([{0, 0}])}, nums).