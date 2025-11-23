-module(solution).
-export([sort_string/1]).

sort_string(S) ->
    Letters = lists:sort(string:to_list(S)),
    Increasing = lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            false -> [X | Acc];
            true -> Acc
        end
    end, [], Letters),
    Decreasing = lists:reverse(Increasing),
    Result = lists:foldl(fun(X, Acc) -> 
        Acc ++ [X] ++ lists:reverse(lists:filter(fun(Y) -> Y == X end, Letters))
    end, [], Increasing),
    string:from_list(Result).