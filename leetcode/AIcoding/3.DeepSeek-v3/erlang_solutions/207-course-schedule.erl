-spec can_finish(NumCourses :: integer(), Prerequisites :: [[integer()]]) -> boolean().
can_finish(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    InDegree = build_in_degree(NumCourses, Prerequisites),
    Queue = queue:from_list([X || X <- lists:seq(0, NumCourses - 1), maps:get(X, InDegree, 0) =:= 0]),
    topological_sort(Graph, InDegree, Queue, 0).

build_graph(NumCourses, Prerequisites) ->
    Graph = maps:from_list([{X, []} || X <- lists:seq(0, NumCourses - 1)]),
    lists:foldl(fun([To, From], Acc) ->
                    maps:update_with(From, fun(Neighbors) -> [To | Neighbors] end, Acc)
                end, Graph, Prerequisites).

build_in_degree(NumCourses, Prerequisites) ->
    InDegree = maps:from_list([{X, 0} || X <- lists:seq(0, NumCourses - 1)]),
    lists:foldl(fun([To, _From], Acc) ->
                    maps:update_with(To, fun(Count) -> Count + 1 end, Acc)
                end, InDegree, Prerequisites).

topological_sort(_Graph, _InDegree, Queue, Count) when Count < 0 -> false;
topological_sort(_Graph, _InDegree, Queue, Count) when queue:is_empty(Queue) -> Count =:= 0;
topological_sort(Graph, InDegree, Queue, Count) ->
    {{value, Node}, NewQueue} = queue:out(Queue),
    Neighbors = maps:get(Node, Graph, []),
    UpdatedInDegree = lists:foldl(fun(Neighbor, Acc) ->
                                    NewCount = maps:get(Neighbor, Acc) - 1,
                                    if NewCount =:= 0 -> queue:in(Neighbor, NewQueue);
                                       true -> ok
                                    end,
                                    maps:update(Neighbor, NewCount, Acc)
                                 end, InDegree, Neighbors),
    topological_sort(Graph, UpdatedInDegree, NewQueue, Count - 1).