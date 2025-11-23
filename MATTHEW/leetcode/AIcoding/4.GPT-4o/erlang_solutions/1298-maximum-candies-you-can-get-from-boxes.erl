-module(solution).
-export([max_candies/2]).

max_candies(BoxTypes, numBoxes) ->
    Lists = lists:map(fun({Count, Type}) -> lists:duplicate(Count, Type) end, BoxTypes),
    Boxes = lists:flatten(Lists),
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            true -> Acc;
            false -> [X | Acc]
        end 
    end, [], Boxes) ++ lists:duplicate(numBoxes - length(Boxes), 0).