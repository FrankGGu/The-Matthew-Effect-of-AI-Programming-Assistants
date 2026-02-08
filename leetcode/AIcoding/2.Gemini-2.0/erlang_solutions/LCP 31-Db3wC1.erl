-module(transforming_maze).
-export([solve/1]).

solve(maze) ->
  {Rows, Cols} = get_dimensions(maze),
  start_row = find_start(maze),
  end_row = find_end(maze),
  queue:new()
    |> queue:in({start_row, 0, 0})
    |> bfs(maze, Rows, Cols, end_row, #{}, #{}).

bfs(Maze, Rows, Cols, EndRow, Visited, Distances) ->
  case queue:out(queue) of
    {empty, _} ->
      -1;
    {{value, {Row, Col, Distance}}, NewQueue} ->
      if Row == EndRow, Col == (Cols - 1) then
        Distance
      else
        Neighbors = get_neighbors(Row, Col, Rows, Cols),
        NewVisited = maps:put({Row, Col}, true, Visited),
        NewDistances = maps:put({Row, Col}, Distance, Distances),
        UpdatedQueue = lists:foldl(
          fun({NewRow, NewCol}, AccQueue) ->
            case {maps:get({NewRow, NewCol}, Visited, false),
                  get_cell(Maze, NewRow, NewCol)} of
              {false, 0} ->
                queue:in({NewRow, NewCol, Distance + 1}, AccQueue);
              _ ->
                AccQueue
            end
          end,
          NewQueue,
          Neighbors
        ),
        bfs(Maze, Rows, Cols, EndRow, NewVisited, NewDistances, UpdatedQueue)
      end
  end.

get_dimensions(Maze) ->
  Rows = length(Maze),
  Cols = length(hd(Maze)),
  {Rows, Cols}.

find_start(Maze) ->
  lists:foldl(
    fun(Row, Acc) ->
      case lists:member(2, Row) of
        true ->
          Index = lists:keyfind(2, 1, lists:zip(lists:seq(1, length(Row)), Row)),
          case Index of
            false -> Acc;
            {Pos, _} -> Pos - 1
          end;
        false ->
          Acc
      end
    end,
    -1,
    Maze
  ).

find_end(Maze) ->
  lists:foldl(
    fun(Row, Acc) ->
      case lists:member(3, Row) of
        true ->
          Index = lists:keyfind(3, 1, lists:zip(lists:seq(1, length(Row)), Row)),
          case Index of
            false -> Acc;
            {Pos, _} -> Pos - 1
          end;
        false ->
          Acc
      end
    end,
    -1,
    Maze
  ).

get_neighbors(Row, Col, Rows, Cols) ->
  PossibleNeighbors = [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}],
  lists:filter(
    fun({R, C}) ->
      R >= 0 and R < Rows and C >= 0 and C < Cols
    end,
    PossibleNeighbors
  ).

get_cell(Maze, Row, Col) ->
  lists:nth(Col + 1, lists:nth(Row + 1, Maze)).