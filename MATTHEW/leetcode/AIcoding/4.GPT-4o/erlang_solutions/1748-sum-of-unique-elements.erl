-module(solution).
-export([sum_of_unique/1]).

sum_of_unique(List) ->
    Unique = lists:foldl(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> maps:update(X, fun(Count) -> Count + 1 end, Acc);
            false -> maps:put(X, 1, Acc)
        end
    end, map:new(), List),
    maps:fold(fun(_, Count, Acc) ->
        if Count == 1 ->
            Acc + 1;
        true ->
            Acc
        end
    end, 0, Unique).