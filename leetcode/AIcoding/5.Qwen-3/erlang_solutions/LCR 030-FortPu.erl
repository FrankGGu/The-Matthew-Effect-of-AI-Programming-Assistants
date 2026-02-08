-module(leetcode).
-export([insert/2, delete/2, get_random/1]).

-record(set, {map, list}).

insert(Key, #set{map = Map, list = List} = State) ->
    case maps:is_key(Key, Map) of
        true -> {false, State};
        false ->
            NewMap = maps:put(Key, length(List), Map),
            NewList = List ++ [Key],
            {true, #set{map = NewMap, list = NewList}}
    end.

delete(Key, #set{map = Map, list = List} = State) ->
    case maps:is_key(Key, Map) of
        false -> {false, State};
        true ->
            Index = maps:get(Key, Map),
            Last = lists:last(List),
            NewMap = maps:remove(Key, maps:put(Last, Index, Map)),
            NewList = lists:sublist(List, length(List) - 1) ++ [Last],
            {true, #set{map = NewMap, list = NewList}}
    end.

get_random(#set{list = List}) ->
    RandomIndex = rand:uniform(length(List)) - 1,
    lists:nth(RandomIndex + 1, List).