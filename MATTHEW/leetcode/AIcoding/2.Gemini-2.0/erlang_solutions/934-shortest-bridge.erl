-module(shortest_bridge).
-export([shortest_bridge/1]).

shortest_bridge(Grid) ->
  {N, M} = {length(Grid), length(hd(Grid))},
  {Island1, _} = find_island(Grid, N, M),
  Queue = queue:from_list(Island1),
  shortest_bridge_helper(Grid, N, M, Queue, 0).

shortest_bridge_helper(Grid, N, M, Queue, Distance) ->
  case queue:is_empty(Queue) of
    true ->
      Distance;
    false ->
      {Value, NewQueue} = queue:dequeue(Queue),
      {Row, Col} = Value,
      Neighbors = get_neighbors(Row, Col, N, M),
      NewNeighbors = lists:filter(fun(Neighbor) ->
                                    {NRow, NCol} = Neighbor,
                                    case lists:nth(NRow + 1, Grid) of
                                      RowList ->
                                        case lists:nth(NCol + 1, RowList) of
                                          0 ->
                                            true;
                                          1 ->
                                            false;
                                          2 ->
                                            false
                                        end;
                                      _ ->
                                        false
                                    end
                                  end, Neighbors),
      case lists:any(fun(Neighbor) ->
                        {NRow, NCol} = Neighbor,
                        lists:nth(NRow + 1, Grid) !:= replace_nth(lists:nth(NRow + 1, Grid), NCol + 1, 2),
                        lists:nth(NRow + 1, Grid) == replace_nth(lists:nth(NRow + 1, Grid), NCol + 1, 1)
                     end, NewNeighbors) of
        true ->
          Distance;
        false ->
          NewGrid = lists:map(fun(Row) -> lists:map(fun(X) -> X end, Row) end, Grid),
          UpdatedQueue = lists:foldl(fun(Neighbor, AccQueue) ->
                                        {NRow, NCol} = Neighbor,
                                        lists:nth(NRow + 1, NewGrid) !:= replace_nth(lists:nth(NRow + 1, NewGrid), NCol + 1, 2),
                                        queue:enqueue(Neighbor, AccQueue)
                                      end, NewQueue, NewNeighbors),
          shortest_bridge_helper(NewGrid, N, M, UpdatedQueue, Distance + 1)
      end
  end.

find_island(Grid, N, M) ->
  find_island_helper(Grid, N, M, 0, 0, []).

find_island_helper(Grid, N, M, Row, Col, Island) ->
  case Row >= N of
    true ->
      {Island, Grid};
    false ->
      case Col >= M of
        true ->
          find_island_helper(Grid, N, M, Row + 1, 0, Island);
        false ->
          case lists:nth(Row + 1, Grid) of
            RowList ->
              case lists:nth(Col + 1, RowList) of
                1 ->
                  {NewIsland, NewGrid} = dfs(Grid, N, M, Row, Col, Island, []),
                  {NewIsland, NewGrid};
                _ ->
                  find_island_helper(Grid, N, M, Row, Col + 1, Island)
              end;
            _ ->
              find_island_helper(Grid, N, M, Row, Col + 1, Island)
          end
      end
  end.

dfs(Grid, N, M, Row, Col, Island, Visited) ->
  case lists:member({Row, Col}, Visited) of
    true ->
      {Island, Grid};
    false ->
      case Row < 0 or Row >= N or Col < 0 or Col >= M of
        true ->
          {Island, Grid};
        false ->
          case lists:nth(Row + 1, Grid) of
            RowList ->
              case lists:nth(Col + 1, RowList) of
                1 ->
                  NewGrid = lists:map(fun(RowList2) -> lists:map(fun(X) -> X end, RowList2) end, Grid),
                  lists:nth(Row + 1, NewGrid) !:= replace_nth(lists:nth(Row + 1, NewGrid), Col + 1, 2),
                  UpdatedIsland = [{Row, Col} | Island],
                  UpdatedVisited = [{Row, Col} | Visited],
                  {Island1, Grid1} = dfs(NewGrid, N, M, Row + 1, Col, UpdatedIsland, UpdatedVisited),
                  {Island2, Grid2} = dfs(Grid1, N, M, Row - 1, Col, Island1, UpdatedVisited),
                  {Island3, Grid3} = dfs(Grid2, N, M, Row, Col + 1, Island2, UpdatedVisited),
                  dfs(Grid3, N, M, Row, Col - 1, Island3, UpdatedVisited);
                _ ->
                  {Island, Grid}
              end;
            _ ->
              {Island, Grid}
          end
      end
  end.

get_neighbors(Row, Col, N, M) ->
  Neighbors = [{Row + 1, Col}, {Row - 1, Col}, {Row, Col + 1}, {Row, Col - 1}],
  lists:filter(fun({R, C}) -> R >= 0 and R < N and C >= 0 and C < M end, Neighbors).

replace_nth(List, N, NewVal) ->
  lists:nth(N, List) !:= NewVal,
  List.