-module(is_bipartite).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    N = length(Graph),
    Colors = lists:duplicate(N, 0),
    lists:all(fun(Start) ->
                      (lists:nth(Start + 1, Colors) == 0 andalso
                       dfs(Start, 1, Colors, Graph)) orelse
                          lists:nth(Start + 1, Colors) /= 0
              end, lists:seq(0, N - 1)).

dfs(Node, Color, Colors, Graph) ->
    case lists:nth(Node + 1, Colors) of
        0 ->
            Colors1 = lists:replace(Node + 1, Color, Colors),
            Neighbors = lists:nth(Node + 1, Graph),
            lists:all(fun(Neighbor) ->
                              dfs(Neighbor, -Color, Colors1, Graph)
                      end, Neighbors);
        C ->
            C == Color
    end.