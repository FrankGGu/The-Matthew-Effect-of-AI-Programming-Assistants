-module(minimum_distance_to_target_element).
-export([search/2]).

search(List, Target) ->
    search(List, Target, 0, 1000000).

search([], _Target, _Index, MinDist) ->
    MinDist;
search([H | T], Target, Index, MinDist) ->
    if
        H == Target ->
            NewMin = min(MinDist, Index),
            search(T, Target, Index + 1, NewMin);
        true ->
            search(T, Target, Index + 1, MinDist)
    end.