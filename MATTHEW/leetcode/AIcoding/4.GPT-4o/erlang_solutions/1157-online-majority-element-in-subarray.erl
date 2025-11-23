-module(majority_element).
-export([majority_element/2]).

majority_element(A, N) ->
    Map = maps:from_list(A),
    List = maps:to_list(Map),
    lists:foldl(fun({Key, Val}, Acc) -> 
        case Val >= N div 2 + 1 of
            true -> [{Key, Val} | Acc];
            false -> Acc
        end
    end, [], List).