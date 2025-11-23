-module(loud_and_rich).
-export([loud_and_rich/2]).

loud_and_rich(richer, quiet) ->
    N = length(quiet),
    Graph = build_graph(richer, N),
    Answer = lists:map(fun(I) -> dfs(I, Graph, quiet) end, lists:seq(0, N - 1)),
    Answer.

build_graph(Richer, N) ->
    Graph = array:new(N, {fixed, []}),
    lists:foreach(fun([U, V]) ->
                      array:set(U, [V | array:get(U, Graph)], Graph)
                  end, Richer),
    Graph.

dfs(Person, Graph, Quiet) ->
    dfs_helper(Person, Graph, Quiet, Person, Quiet[Person + 1], Person).

dfs_helper(Person, Graph, Quiet, CurrentPerson, CurrentQuiet, CurrentBest) ->
    Neighbors = array:get(CurrentPerson, Graph),
    case Neighbors of
        [] ->
            CurrentBest;
        _ ->
            lists:foldl(fun(Neighbor, {BestPerson, BestQuiet}) ->
                              NeighborQuiet = Quiet[Neighbor + 1],
                              case NeighborQuiet < BestQuiet of
                                  true ->
                                      {Neighbor, NeighborQuiet};
                                  false ->
                                      {BestPerson, BestQuiet}
                              end
                         end, {CurrentBest, CurrentQuiet}, Neighbors) of
                {BestPerson, _BestQuiet} ->
                    BestPerson
            end
    end.