-module(randomized_set).
-export([init/0, insert/2, remove/2, getRandom/1]).

init() ->
    {maps:new(), []}.

insert({Map, List}, Val) ->
    case maps:is_key(Val, Map) of
        true ->
            {Map, List};
        false ->
            NewMap = maps:put(Val, length(List), Map),
            NewList = List ++ [Val],
            {NewMap, NewList}
    end.

remove({Map, List}, Val) ->
    case maps:is_key(Val, Map) of
        true ->
            Index = maps:get(Val, Map),
            LastVal = lists:last(List),
            NewMap = maps:remove(Val, Map),
            NewList =
                if Val == LastVal then
                    lists:droplast(List)
                else
                    NewList1 = lists:nth(Index, List) ,
                    NewList2 = lists:nthtail(Index +1 , List),
                    lists:sublist(List,1,Index) ++ [LastVal] ++ NewList2,
                    lists:droplast(List),
                    lists:sublist(List,1,Index) ++ [LastVal] ++ lists:nthtail(Index +1 , lists:droplast(List))
                end,
            NewMap2 =
                if Val == LastVal then
                    NewMap
                else
                    maps:update(LastVal, Index, NewMap)
                end,

            {NewMap2, NewList};
        false ->
            {Map, List}
    end.

getRandom({Map, List}) ->
    Len = length(List),
    if Len == 0 then
        undefined
    else
        Index = rand:uniform(Len) - 1,
        lists:nth(Index, List)
    end.