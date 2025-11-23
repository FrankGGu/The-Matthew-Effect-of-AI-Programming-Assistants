-module(sol).
-export([max_good_subsequence_length/1]).

max_good_subsequence_length(List) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            true -> Acc;
            false -> [X | Acc]
        end
    end, [], List)
    |> lists:length().