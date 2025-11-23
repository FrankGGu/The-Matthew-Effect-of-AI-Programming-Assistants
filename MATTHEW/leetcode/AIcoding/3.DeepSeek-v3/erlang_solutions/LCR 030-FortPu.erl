-module(randomized_set).
-export([init/0, insert/1, remove/1, get_random/0]).

init() ->
    {#{}, #{}, 0}.

insert(Val, {Map, RevMap, Size}) ->
    case maps:is_key(Val, RevMap) of
        true ->
            {false, {Map, RevMap, Size}};
        false ->
            NewSize = Size + 1,
            NewMap = maps:put(NewSize, Val, Map),
            NewRevMap = maps:put(Val, NewSize, RevMap),
            {true, {NewMap, NewRevMap, NewSize}}
    end.

remove(Val, {Map, RevMap, Size}) ->
    case maps:is_key(Val, RevMap) of
        false ->
            {false, {Map, RevMap, Size}};
        true ->
            Idx = maps:get(Val, RevMap),
            LastVal = maps:get(Size, Map),
            NewMap1 = maps:put(Idx, LastVal, Map),
            NewMap2 = maps:remove(Size, NewMap1),
            NewRevMap1 = maps:put(LastVal, Idx, RevMap),
            NewRevMap2 = maps:remove(Val, NewRevMap1),
            {true, {NewMap2, NewRevMap2, Size - 1}}
    end.

get_random({Map, _, Size}) ->
    Idx = rand:uniform(Size),
    maps:get(Idx, Map).