-module(largest_color_value).
-export([largest_path_value/2]).

largest_path_value(Colors, Edges) ->
  N = length(Colors),
  Graph = create_graph(Edges, N),
  in_degree(Graph, N, InDegree),
  topological_sort(Colors, Graph, InDegree, N).

create_graph(Edges, N) ->
  lists:foldl(
    fun({U, V}, Acc) ->
      case maps:is_key(U, Acc) of
        true -> maps:update(U, [V | maps:get(U, Acc)], Acc);
        false -> maps:put(U, [V], Acc)
      end
    end,
    maps:new(),
    Edges
  ).

in_degree(Graph, N, InDegree) ->
  lists:foldl(
    fun(I, Acc) ->
      maps:put(I, 0, Acc)
    end,
    maps:new(),
    lists:seq(1, N)
  ),
  lists:foldl(
    fun(U, Acc0) ->
      case maps:is_key(U, Graph) of
        true ->
          Neighbors = maps:get(U, Graph),
          lists:foldl(
            fun(V, Acc) ->
              maps:update(V, maps:get(V, Acc) + 1, Acc)
            end,
            Acc0,
            Neighbors
          );
        false -> Acc0
      end
    end,
    maps:new(),
    lists:seq(1, N),
    InDegree1 = lists:foldl(
      fun(I, Acc) ->
        case maps:is_key(I, Acc) of
          true -> Acc;
          false -> maps:put(I, 0, Acc)
        end
      end,
      maps:new(),
      lists:seq(1, N),
      InDegree2 = lists:foldl(
        fun({U, V}, Acc) ->
          lists:foldl(
            fun(Vertex, Acc2) ->
              maps:update(Vertex, maps:get(Vertex, Acc2) + 1, Acc2)
            end,
            Acc,
            [V]
          )
        end,
        InDegree1,
        Edges,
        InDegree3 = lists:foldl(
          fun(I, Acc) ->
            case maps:is_key(I, Acc) of
              true -> Acc;
              false -> maps:put(I, 0, Acc)
            end
          end,
          maps:new(),
          lists:seq(1, N)
        )
      )
    )
  ),
  lists:foldl(
    fun({U, V}, Acc) ->
      lists:foldl(
        fun(Vertex, Acc2) ->
          case maps:is_key(Vertex, Acc2) of
            true ->
              maps:update(Vertex, maps:get(Vertex, Acc2) + 1, Acc2);
            false ->
              maps:put(Vertex, 1, Acc2)
          end
        end,
        Acc,
        [V]
      )
    end,
    InDegree,
    Edges
  ).

topological_sort(Colors, Graph, InDegree, N) ->
  Queue = [V || V <- lists:seq(1, N), maps:get(V, InDegree) == 0],
  DP = create_dp(Colors, N),
  {Result, Count} = bfs(Colors, Graph, InDegree, Queue, DP, 0, 0, N),
  if Count == N -> Result;
     true -> -1
  end.

create_dp(Colors, N) ->
  lists:foldl(
    fun(I, Acc) ->
      maps:put(I, lists:duplicate(26, 0), Acc)
    end,
    maps:new(),
    lists:seq(1, N),
    DP = lists:foldl(
      fun(I, Acc) ->
        Char = lists:nth(I, Colors),
        Index = Char - $a + 1,
        NewList = lists:nthtail(Index - 1, lists:duplicate(Index - 1, 0)) ++ [1] ++ lists:nthtail(26 - Index, lists:duplicate(26 - Index, 0)),
        maps:put(I, NewList, Acc)
      end,
      maps:new(),
      lists:seq(1, N)
    ),
    lists:foldl(
      fun(I, Acc) ->
        Char = lists:nth(I, Colors),
        Index = Char - $a + 1,
        NewList = lists:nthtail(Index - 1, lists:duplicate(Index - 1, 0)) ++ [1] ++ lists:nthtail(26 - Index, lists:duplicate(26 - Index, 0)),
        maps:put(I, NewList, Acc)
      end,
      maps:new(),
      lists:seq(1, N)
    )
  ).

bfs(Colors, Graph, InDegree, [], DP, Result, Count, _) ->
  {Result, Count};
bfs(Colors, Graph, InDegree, [U | Rest], DP, Result, Count, N) ->
  Char = lists:nth(U, Colors),
  Index = Char - $a + 1,
  Value = lists:nth(Index, maps:get(U, DP)),
  NewResult = max(Result, Value),
  case maps:is_key(U, Graph) of
    true ->
      Neighbors = maps:get(U, Graph),
      lists:foldl(
        fun(V, {NewInDegree, NewDP, NewQueue}) ->
          NewInDegreeV = maps:get(V, NewInDegree) - 1,
          maps:update(V, NewInDegreeV, NewInDegree1),
          NewDPV = combine_dp(maps:get(U, DP), maps:get(V, NewDP)),
          maps:update(V, NewDPV, NewDP2),
          NewQueue2 = if NewInDegreeV == 0 then [V | NewQueue] else NewQueue,
          {NewInDegree1, NewDP2, NewQueue2}
        end,
        {InDegree, DP, Rest},
        Neighbors,
        {NewInDegree, NewDP, NewQueue}
      ),
      bfs(Colors, Graph, NewInDegree, NewQueue, NewDP, NewResult, Count + 1, N);
    false ->
      bfs(Colors, Graph, InDegree, Rest, DP, NewResult, Count + 1, N)
  end.

combine_dp(DP1, DP2) ->
  lists:map(
    fun({X, Y}) ->
      max(X, Y)
    end,
    lists:zip(DP1, DP2)
  ).