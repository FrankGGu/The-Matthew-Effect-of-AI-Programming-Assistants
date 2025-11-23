-module(course_schedule_ii).
-export([find_order/2]).

find_order(NumCourses, Prerequisites) ->
  graph_and_indegree(NumCourses, Prerequisites, Graph, InDegree),
  topological_sort(Graph, InDegree, [], NumCourses).

graph_and_indegree(NumCourses, Prerequisites, Graph, InDegree) ->
  graph_and_indegree(Prerequisites, create_graph(NumCourses), create_indegree(NumCourses), Graph, InDegree).

graph_and_indegree([], Graph, InDegree, Graph, InDegree) ->
  {Graph, InDegree};
graph_and_indegree([[Course, Pre] | Rest], Graph, InDegree, GraphOut, InDegreeOut) ->
  NewGraph = maps:update_with(Pre, fun(Neighbors) -> [Course | Neighbors] end, [Course], Graph),
  NewInDegree = maps:update_with(Course, fun(Count) -> Count + 1 end, 1, InDegree),
  graph_and_indegree(Rest, NewGraph, NewInDegree, GraphOut, InDegreeOut).

create_graph(NumCourses) ->
  lists:foldl(fun(I, Acc) -> maps:put(I, [], Acc) end, #{}, lists:seq(0, NumCourses - 1)).

create_indegree(NumCourses) ->
  lists:foldl(fun(I, Acc) -> maps:put(I, 0, Acc) end, #{}, lists:seq(0, NumCourses - 1)).

topological_sort(Graph, InDegree, Sorted, NumCourses) ->
  ZeroDegree = [Course || Course <- maps:keys(InDegree), maps:get(Course, InDegree) == 0],
  topological_sort(Graph, InDegree, Sorted, ZeroDegree, NumCourses).

topological_sort(_Graph, _InDegree, Sorted, [], 0) ->
  lists:reverse(Sorted);
topological_sort(_Graph, _InDegree, _Sorted, [], _NumCourses) ->
  [];
topological_sort(Graph, InDegree, Sorted, [Course | Rest], NumCourses) ->
  NewSorted = [Course | Sorted],
  NewGraph = maps:get(Course, Graph, []),
  {NewInDegree, Count} = update_indegree(InDegree, NewGraph),
  topological_sort(Graph, NewInDegree, NewSorted, Rest ++ [C || C <- maps:keys(NewInDegree), maps:get(C, NewInDegree) == 0, not lists:member(C, Rest)], NumCourses - 1).

update_indegree(InDegree, []) ->
  {InDegree, 0};
update_indegree(InDegree, [Course | Rest]) ->
  NewInDegree = maps:update_with(Course, fun(Count) -> Count - 1 end, 0, InDegree),
  update_indegree(NewInDegree, Rest).