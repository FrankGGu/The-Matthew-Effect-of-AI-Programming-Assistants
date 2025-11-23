-module(contains_duplicate_ii).
-export([contains_nearby_duplicate/2]).

contains_nearby_duplicate(Nums, K) ->
    contains_nearby_duplicate(Nums, K, dict:new()).

contains_nearby_duplicate([], _, _) ->
    false;
contains_nearby_duplicate([H|T], K, Dict) ->
    case dict:find(H, Dict) of
        {ok, Index} ->
            if abs(Index - 1) =< K then
                true
            else
                contains_nearby_duplicate(T, K, dict:store(H, 1, Dict))
            end;
        error ->
            contains_nearby_duplicate(T, K, dict:store(H, 1, Dict))
    end.