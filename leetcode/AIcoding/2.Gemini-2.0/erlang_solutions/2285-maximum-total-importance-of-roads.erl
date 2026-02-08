-module(maximum_importance).
-export([maximum_importance/2]).

maximum_importance(n, roads) ->
  DegreeList = lists:seq(1, n),
  Degrees = lists:map(fun(X) -> count_degree(X, roads) end, DegreeList),
  SortedDegrees = lists:sort(Degrees),
  ImportanceMap = create_importance_map(SortedDegrees),
  lists:foldl(fun([U, V], Acc) ->
                  Acc + ImportanceMap ! U + ImportanceMap ! V
              end, 0, roads).

count_degree(Node, Roads) ->
  lists:foldl(fun([U, V], Acc) ->
                  if U =:= Node orelse V =:= Node then
                    Acc + 1
                  else
                    Acc
                  end
              end, 0, Roads).

create_importance_map(SortedDegrees) ->
  create_importance_map(SortedDegrees, dict:new(), 1).

create_importance_map([], Map, _) ->
  Map;
create_importance_map([H|T], Map, Importance) ->
  NewMap = dict:store(H, Importance, Map),
  create_importance_map(T, NewMap, Importance + 1).