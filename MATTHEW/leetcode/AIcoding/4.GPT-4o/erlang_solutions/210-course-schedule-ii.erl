%% -spec find_order(NumCourses :: integer(), Prerequisites :: [[integer()]]) -> [integer()].
find_order(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    TopologicalSort = topological_sort(Graph),
    case length(TopologicalSort) == NumCourses of
        true -> TopologicalSort;
        false -> []
    end.

-spec build_graph(NumCourses :: integer(), Prerequisites :: [[integer()]]) -> [{integer(), [integer()]}].
build_graph(NumCourses, Prerequisites) ->
    lists:map(fun(X) -> {element(1, X), [element(2, X)]} end, Prerequisites).

-spec topological_sort(Graph :: [{integer(), [integer()]}]) -> [integer()].
topological_sort(Graph) ->
    topological_sort_helper(Graph, [], []).

-spec topological_sort_helper(Graph :: [{integer(), [integer()]}], Visited :: [integer()], Result :: [integer()]) -> [integer()].
topological_sort_helper([], Visited, Result) -> lists:reverse(Result);
topological_sort_helper([{Node, Neighbors} | Rest], Visited, Result) when not lists:member(Node, Visited) ->
    topological_sort_helper(Rest, [Node | Visited], [Node | Result]);
topological_sort_helper([_ | Rest], Visited, Result) ->
    topological_sort_helper(Rest, Visited, Result).
