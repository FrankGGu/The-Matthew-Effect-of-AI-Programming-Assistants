-module(path_with_max_probability).
-export([max_probability/3]).

max_probability(N, Edges, SuccProb) ->
  Graph = build_graph(N, Edges, SuccProb),
  dijkstra(N, Graph, 0, N - 1).

build_graph(N, Edges, SuccProb) ->
  lists:foldl(fun({[U, V], P}, Acc) ->
                  Acc#{U => lists:append(maps:get(U, Acc, []), [{V, P}]),
                        V => lists:append(maps:get(V, Acc, []), [{U, P}])}
              end, #{}, lists:zip(Edges, SuccProb)).

dijkstra(N, Graph, Start, End) ->
  Dist = maps:from_list([{I, 0.0} || I <- lists:seq(0, N - 1)]),
  Dist1 = maps:put(Start, 1.0, Dist),
  Q = priority_queue:new(),
  Q1 = priority_queue:insert(Start, -1.0, Q),
  dijkstra_helper(Graph, Dist1, Q1, End).

dijkstra_helper(Graph, Dist, Q, End) ->
  case priority_queue:is_empty(Q) of
    true ->
      maps:get(End, Dist, 0.0);
    false ->
      {U, NegProb, Q2} = priority_queue:delete_max(Q),
      Prob = -NegProb,
      case Prob < maps:get(U, Dist) of
        true ->
          dijkstra_helper(Graph, Dist, Q2, End);
        false ->
          Neighbors = maps:get(U, Graph, []),
          {Dist2, Q3} = lists:foldl(fun({V, P}, {AccDist, AccQ}) ->
                                        NewProb = Prob * P,
                                        case NewProb > maps:get(V, AccDist, 0.0) of
                                          true ->
                                            {maps:put(V, NewProb, AccDist), priority_queue:insert(V, -NewProb, AccQ)};
                                          false ->
                                            {AccDist, AccQ}
                                        end
                                      end, {Dist, Q2}, Neighbors),
          dijkstra_helper(Graph, Dist2, Q3, End)
      end
  end.