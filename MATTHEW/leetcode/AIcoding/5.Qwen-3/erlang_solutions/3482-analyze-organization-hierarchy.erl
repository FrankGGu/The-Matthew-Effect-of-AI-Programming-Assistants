-module(analyze_organization_hierarchy).
-export([full_benefit/1]).

full_benefit(Reports) ->
    Map = maps:from_list([{Id, Name} || [Id, Name] <- Reports]),
    Children = maps:from_list([{Parent, []} || [_, Parent] <- Reports ++ [[0, 0]]]),
    lists:foldl(fun([Id, _, Parent], Acc) ->
                        maps:update(Parent, [Id | maps:get(Parent, Acc)], Acc)
                end, Children, Reports),
    build_tree(0, Map, Children).

build_tree(Id, Map, Children) ->
    ChildrenList = maps:get(Id, Children, []),
    lists:map(fun(ChildId) ->
                      ChildName = maps:get(ChildId, Map),
                      {ChildName, build_tree(ChildId, Map, Children)}
              end, ChildrenList).