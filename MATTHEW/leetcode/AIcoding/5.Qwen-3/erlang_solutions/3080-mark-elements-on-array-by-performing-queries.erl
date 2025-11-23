-module(solution).
-export([mark_elements/1]).

mark_elements(Nums) ->
    mark_elements(Nums, 0, #{}).

mark_elements([], _, _) ->
    [];
mark_elements([N | T], Index, Map) ->
    case maps:is_key(N, Map) of
        true ->
            [maps:get(N, Map) | mark_elements(T, Index + 1, Map)];
        false ->
            NewMap = maps:put(N, Index, Map),
            [Index | mark_elements(T, Index + 1, NewMap)]
    end.