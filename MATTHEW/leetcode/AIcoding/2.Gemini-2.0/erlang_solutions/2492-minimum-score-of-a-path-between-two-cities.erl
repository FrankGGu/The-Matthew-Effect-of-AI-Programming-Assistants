-module(minimum_score).
-export([minimum_score/2]).

minimum_score(N, Roads) ->
  Graph = build_graph(Roads),
  bfs(1, N, Graph).

build_graph(Roads) ->
  lists:foldl(
    fun([U, V, Distance], Acc) ->
      Acc#{
        U => maps:get(U, Acc, []) ++ [{V, Distance}],
        V => maps:get(V, Acc, []) ++ [{U, Distance}]
      }
    end,
    #{},
    Roads
  ).

bfs(Start, End, Graph) ->
  bfs_helper([Start], #{Start => true}, infinity, Graph).

bfs_helper([], _, MinScore, _) ->
  MinScore;
bfs_helper(Queue, Visited, MinScore, Graph) ->
  case Queue of
    [] ->
      MinScore;
    [City | Rest] ->
      Neighbors = maps:get(City, Graph, []),
      {NewQueue, NewVisited, NewMinScore} =
        lists:foldl(
          fun({Neighbor, Distance}, {QAcc, VAcc, MSAcc}) ->
            case maps:get(Neighbor, VAcc, false) of
              false ->
                {[Neighbor | QAcc], VAcc#{Neighbor => true}, min(MSAcc, Distance)};
              true ->
                {QAcc, VAcc, MSAcc}
            end
          end,
          {[], Visited, MinScore},
          Neighbors
        ),
      bfs_helper(Rest ++ lists:reverse(NewQueue), NewVisited, NewMinScore, Graph)
  end.

infinity() ->
  math:pow(10, 9) + 1.