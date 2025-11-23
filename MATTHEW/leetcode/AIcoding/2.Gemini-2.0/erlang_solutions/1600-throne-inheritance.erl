-module(throne_inheritance).
-export([start/1, birth/3, death/1, getInheritanceOrder/1]).

start(kingName) ->
    {ok, dict:new(), dict:from_list([{kingName, alive}])}.

birth(parentName, childName, {AliveDict, InheritanceDict}) ->
    NewInheritanceDict = dict:append(parentName, childName, InheritanceDict),
    {AliveDict, NewInheritanceDict}.

death(name, {AliveDict, InheritanceDict}) ->
    NewAliveDict = dict:update(name, dead, AliveDict),
    {NewAliveDict, InheritanceDict}.

getInheritanceOrder({AliveDict, InheritanceDict}) ->
    King = lists:keyfind(alive, 2, dict:to_list(AliveDict)),
    case King of
        {KingName, alive} ->
            inheritanceOrder(KingName, AliveDict, InheritanceDict, [])
    end.

inheritanceOrder(Name, AliveDict, InheritanceDict, Acc) ->
    case dict:find(Name, AliveDict) of
        {ok, alive} ->
            NewAcc = [Name | Acc],
            Children = dict:fetch(Name, InheritanceDict, []),
            lists:foldl(fun(Child, Acc1) ->
                                 inheritanceOrder(Child, AliveDict, InheritanceDict, Acc1)
                         end,
                         NewAcc,
                         Children);
        error ->
            Children = dict:fetch(Name, InheritanceDict, []),
            lists:foldl(fun(Child, Acc1) ->
                                 inheritanceOrder(Child, AliveDict, InheritanceDict, Acc1)
                         end,
                         Acc,
                         Children)
    end.