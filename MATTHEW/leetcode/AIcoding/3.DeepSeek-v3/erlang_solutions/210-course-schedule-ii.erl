-spec find_order(NumCourses :: integer(), Prerequisites :: [[integer()]]) -> [integer()].
find_order(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    InDegree = build_in_degree(NumCourses, Prerequisites),
    Queue = initialize_queue(InDegree),
    topological_sort(Graph, InDegree, Queue, []).

build_graph(NumCourses, Prerequisites) ->
    Graph = maps:from_list([{I, []} || I <- lists:seq(0, NumCourses - 1)]),
    lists:foldl(fun([To, From], Acc) ->
                    maps:update_with(From, fun(Neighbors) -> [To | Neighbors] end, Acc)
                end, Graph, Prerequisites).

build_in_degree(NumCourses, Prerequisites) ->
    InDegree = maps:from_list([{I, 0} || I <- lists:seq(0, NumCourses - 1)]),
    lists:foldl(fun([To, _From], Acc) ->
                    maps:update_with(To, fun(Count) -> Count + 1 end, Acc)
                end, InDegree, Prerequisites).

initialize_queue(InDegree) ->
    maps:fold(fun(Node, Count, Queue) when Count =:= 0 ->
                    queue:in(Node, Queue);
                 (_, _, Queue) ->
                    Queue
              end, queue:new(), InDegree).

topological_sort(_Graph, _InDegree, Queue, Result) when queue:is_empty(Queue) ->
    case length(Result) of
        N when N =:= map_size(_InDegree) -> lists:reverse(Result);
        _ -> []
    end;
topological_sort(Graph, InDegree, Queue, Result) ->
    {{value, Node}, NewQueue} = queue:out(Queue),
    NewResult = [Node | Result],
    Neighbors = maps:get(Node, Graph, []),
    {UpdatedInDegree, UpdatedQueue} =
        lists:foldl(fun(Neighbor, {InDeg, Q}) ->
                        NewCount = maps:get(Neighbor, InDeg) - 1,
                        NewInDeg = maps:update(Neighbor, NewCount, InDeg),
                        case NewCount of
                            0 -> {NewInDeg, queue:in(Neighbor, Q)};
                            _ -> {NewInDeg, Q}
                        end
                    end, {InDegree, NewQueue}, Neighbors),
    topological_sort(Graph, UpdatedInDegree, UpdatedQueue, NewResult).