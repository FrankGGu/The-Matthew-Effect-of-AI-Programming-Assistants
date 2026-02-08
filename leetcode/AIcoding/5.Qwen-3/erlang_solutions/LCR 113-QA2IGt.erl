-module(course_schedule_ii).
-export([find_order/2]).

find_order(N, Relations) ->
    InDegree = lists:duplicate(N, 0),
    Graph = lists:seq(0, N-1),
    GraphMap = maps:new(),
    lists:foreach(fun({A, B}) ->
                      InDegree1 = lists:nth(B+1, InDegree),
                      NewInDegree = lists:sublist(InDegree, B) ++ [InDegree1 + 1] ++ lists:sublist(InDegree, B+1, N - B - 1),
                      InDegree = NewInDegree,
                      GraphMap1 = case maps:get(A, GraphMap, []) of
                                      [] -> maps:put(A, [B], GraphMap);
                                      L -> maps:put(A, [B | L], GraphMap)
                                  end,
                      GraphMap = GraphMap1
                  end, Relations),
    Queue = lists:filter(fun(I) -> lists:nth(I+1, InDegree) == 0 end, lists:seq(0, N-1)),
    Result = topological_sort(Queue, InDegree, GraphMap, []),
    if length(Result) == N -> Result;
       true -> []
    end.

topological_sort([], _, _, Acc) -> Acc;
topological_sort([H | T], InDegree, GraphMap, Acc) ->
    Acc1 = [H | Acc],
    Neighbors = maps:get(H, GraphMap, []),
    lists:foreach(fun(Node) ->
                      InDegree1 = lists:nth(Node+1, InDegree),
                      NewInDegree = lists:sublist(InDegree, Node) ++ [InDegree1 - 1] ++ lists:sublist(InDegree, Node+1, N - Node - 1),
                      InDegree = NewInDegree,
                      if InDegree1 - 1 == 0 -> topological_sort([Node | T], InDegree, GraphMap, Acc1);
                         true -> topological_sort(T, InDegree, GraphMap, Acc1)
                      end
                  end, Neighbors),
    topological_sort(T, InDegree, GraphMap, Acc1).