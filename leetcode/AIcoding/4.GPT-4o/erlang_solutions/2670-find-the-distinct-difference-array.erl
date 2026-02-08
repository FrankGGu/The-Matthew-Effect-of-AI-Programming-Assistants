-module(solution).
-export([distinct_difference_array/1]).

distinct_difference_array(List) ->
    N = length(List),
    DistinctLeft = lists:foldl(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> Acc;
            false -> maps:put(X, true, Acc)
        end
    end, #{}, List),

    DistinctRight = lists:foldr(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> Acc;
            false -> maps:put(X, true, Acc)
        end
    end, #{}, List),

    lists:map(fun(X) ->
        LeftCount = maps:size(maps:filter(fun(K, _) -> K =< X end, DistinctLeft)),
        RightCount = maps:size(maps:filter(fun(K, _) -> K > X end, DistinctRight)),
        LeftCount - RightCount
    end, List).