-module(randomized_set).
-export([init/0, insert/1, remove/1, get_random/0]).

init() ->
    {#{}, #{}, []}.

insert(Val, {Map, IndexMap, List}) ->
    case maps:is_key(Val, Map) of
        true ->
            {false, {Map, IndexMap, List}};
        false ->
            NewList = List ++ [Val],
            NewMap = maps:put(Val, length(NewList),
            NewIndexMap = maps:put(length(NewList), Val, IndexMap),
            {true, {NewMap, NewIndexMap, NewList}}
    end.

remove(Val, {Map, IndexMap, List}) ->
    case maps:is_key(Val, Map) of
        false ->
            {false, {Map, IndexMap, List}};
        true ->
            Index = maps:get(Val, Map),
            LastVal = lists:last(List),
            NewList = lists:sublist(List, length(List) - 1),
            NewMap1 = maps:put(LastVal, Index, maps:remove(Val, Map)),
            NewIndexMap1 = maps:put(Index, LastVal, maps:remove(length(List), IndexMap)),
            NewIndexMap2 = maps:remove(length(List), NewIndexMap1),
            {true, {NewMap1, NewIndexMap2, NewList}}
    end.

get_random({_Map, IndexMap, List}) ->
    RandomIndex = rand:uniform(length(List)),
    maps:get(RandomIndex, IndexMap).