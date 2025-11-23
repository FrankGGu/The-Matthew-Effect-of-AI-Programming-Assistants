-module(shortest_path_weighted_tree).
-export([shortest_path/2]).

shortest_path(N, Edges) ->
  Graph = build_graph(N, Edges),
  dijkstra(1, N, Graph).

build_graph(N, Edges) ->
  lists:foldl(
    fun([U, V, W], Acc) ->
      Acc1 = maps:update_with(U, fun(Adj) -> [{V, W} | Adj] end, [{V, W}], Acc),
      maps:update_with(V, fun(Adj) -> [{U, W} | Adj] end, [{U, W}], Acc1)
    end,
    maps:from_list([{I, []} || I <- lists:seq(1, N)]),
    Edges
  ).

dijkstra(Start, End, Graph) ->
  N = maps:size(Graph),
  Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
  Dist1 = maps:put(Start, 0, Dist),
  PQ = gb_sets:empty(),
  PQ1 = gb_sets:add({0, Start}, PQ),

  dijkstra_helper(End, Graph, Dist1, PQ1, N).

dijkstra_helper(End, Graph, Dist, PQ, N) ->
  case gb_sets:is_empty(PQ) of
    true ->
      case maps:get(End, Dist) of
        infinity -> -1;
        D -> D
      end;
    false ->
      {{D, U}, PQ2} = gb_sets:take_smallest(PQ),
      case D > maps:get(U, Dist) of
        true ->
          dijkstra_helper(End, Graph, Dist, PQ2, N);
        false ->
          Neighbors = maps:get(U, Graph),
          {NewDist, NewPQ} = lists:foldl(
            fun({V, W}, {AccDist, AccPQ}) ->
              DistUV = maps:get(U, AccDist) + W,
              case DistUV < maps:get(V, AccDist) of
                true ->
                  AccDist1 = maps:put(V, DistUV, AccDist),
                  AccPQ1 = gb_sets:add({DistUV, V}, AccPQ),
                  {AccDist1, AccPQ1};
                false ->
                  {AccDist, AccPQ}
              end
            end,
            {Dist, PQ2},
            Neighbors
          ),
          dijkstra_helper(End, Graph, NewDist, NewPQ, N)
      end
  end.