-module(throne_inheritance).
-export([new/1, birth/3, death/2, get_inheritance_order/1]).

-record(person, {name, alive = true, children = []}).

new(KingName) ->
    #{KingName => #person{name = KingName}}.

birth(ParentName, ChildName, Map) ->
    Parent = maps:get(ParentName, Map),
    UpdatedParent = Parent#person{children = [ChildName | Parent#person.children]},
    UpdatedMap = maps:put(ParentName, UpdatedParent, Map),
    maps:put(ChildName, #person{name = ChildName}, UpdatedMap).

death(Name, Map) ->
    Person = maps:get(Name, Map),
    UpdatedPerson = Person#person{alive = false},
    maps:put(Name, UpdatedPerson, Map).

get_inheritance_order(Map) ->
    case maps:to_list(Map) of
        [] -> [];
        [{KingName, _} | _] -> dfs(KingName, Map, [])
    end.

dfs(Name, Map, Acc) ->
    Person = maps:get(Name, Map),
    NewAcc = case Person#person.alive of
        true -> [Name | Acc];
        false -> Acc
    end,
    lists:foldl(fun(Child, A) -> dfs(Child, Map, A) end, NewAcc, Person#person.children).