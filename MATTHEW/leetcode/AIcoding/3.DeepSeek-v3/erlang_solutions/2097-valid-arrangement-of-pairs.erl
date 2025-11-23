-module(solution).
-export([valid_arrangement/1]).

valid_arrangement(Pairs) ->
    Graph = build_graph(Pairs),
    {Start, _} = find_start(Graph),
    Path = eulerian_path(Graph, Start),
    Path.

build_graph(Pairs) ->
    lists:foldl(fun([U, V], Acc) ->
                    Out = maps:get(U, Acc, []),
                    In = maps:get(V, Acc, []),
                    Acc1 = maps:put(U, [V | Out], Acc),
                    maps:put(V, In, Acc1)
                end, #{}, Pairs).

find_start(Graph) ->
    {Starts, Ends} = maps:fold(fun(U, Out, {S, E}) ->
                                   OutDegree = length(Out),
                                   InDegree = case maps:get(U, Graph, []) of
                                                undefined -> 0;
                                                In -> length(In)
                                              end,
                                   if
                                       OutDegree > InDegree -> {[U | S], E};
                                       true -> {S, E}
                                   end
                               end, {[], []}, Graph),
    case Starts of
        [Start | _] -> {Start, lists:nth(1, Ends)};
        [] -> {hd(maps:keys(Graph)), hd(maps:keys(Graph)))}
    end.

eulerian_path(Graph, Start) ->
    Path = [],
    Stack = [Start],
    eulerian_path(Graph, Stack, Path).

eulerian_path(_Graph, [], Path) -> lists:reverse(Path);
eulerian_path(Graph, [U | Stack], Path) ->
    case maps:get(U, Graph, []) of
        [] -> eulerian_path(Graph, Stack, [U | Path]);
        [V | Vs] ->
            Graph1 = maps:put(U, Vs, Graph),
            eulerian_path(Graph1, [V, U | Stack], Path)
    end.