%% -spec can_finish(NumCourses :: integer(), Prerequisites :: [[integer()]]) -> boolean().
can_finish(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    not has_cycle(Graph).

%% Build graph from prerequisites.
build_graph(NumCourses, Prerequisites) ->
    lists:foldl(fun([Course, Prereq], Acc) ->
                    case lists:keyfind(Course, 1, Acc) of
                        false -> [{Course, [Prereq]} | Acc];
                        {Course, Prereqs} -> [{Course, [Prereq | Prereqs]} | lists:keydelete(Course, 1, Acc)]
                    end
                end, lists:duplicate(NumCourses, {_, []}), Prerequisites).

%% Check if there's a cycle using DFS.
has_cycle(Graph) ->
    lists:foldl(fun({Course, _}, Acc) ->
                    case Acc of
                        {_, false} -> false;
                        {Visited, _} when lists:member(Course, Visited) -> true;
                        {Visited, false} -> dfs(Course, Graph, Visited);
                    end
                end, {[], false}, Graph).

%% Perform DFS traversal to detect cycles.
dfs(Course, Graph, Visited) ->
    case lists:keyfind(Course, 1, Graph) of
        {Course, Neighbors} ->
            dfs_visit(Neighbors, [Course | Visited], Graph);
        false -> false
    end.

%% Visit nodes in DFS traversal.
dfs_visit([], _, _) -> false;
dfs_visit([Next | Rest], Visited, Graph) ->
    if
        lists:member(Next, Visited) -> true;
        true -> dfs(Next, Graph, Visited)
    end.
