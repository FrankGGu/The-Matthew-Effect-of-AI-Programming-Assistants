-module(contains_duplicate_ii).
-export([contains_duplicate/2]).

contains_duplicate(Nums, k) ->
    Map = maps:new(),
    contains_duplicate(Nums, k, Map, 0).

contains_duplicate([], _, _, _) ->
    false;
contains_duplicate([H | T], K, Map, Index) ->
    case maps:find(H, Map) of
        {ok, PrevIndex} when abs(Index - PrevIndex) =< K ->
            true;
        _ ->
            NewMap = maps:put(H, Index, Map),
            contains_duplicate(T, K, NewMap, Index + 1)
    end.