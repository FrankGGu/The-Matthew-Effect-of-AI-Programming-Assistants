-module(nearest_exit).
-export([nearest_exit/3]).

nearest_exit(Maze, Entrance, Exits) ->
    {Rows, Cols} = {length(Maze), length(Maze[0])},
    Queue = [{Entrance, 0}],
    Visited = sets:new(),
    nearest_exit_helper(Maze, Rows, Cols, Queue, sets:add_element(Entrance, Visited), Exits).

nearest_exit_helper(_Maze, _Rows, _Cols, [], _Visited, _Exits) ->
    -1;
nearest_exit_helper(Maze, Rows, Cols, [{Current, Distance} | Rest], Visited, Exits) ->
    case lists:member(Current, Exits) of
        true ->
            case Current =/= lists:nth(1, Exits) of
                true ->
                  Distance;
                false ->
                  case lists:member(Current, Exits) of
                    true ->
                      case length(Exits) == 1 of
                        true ->
                          case is_valid_exit(Current, Rows, Cols) of
                            true ->
                              Distance;
                            false ->
                              nearest_exit_helper(Maze, Rows, Cols, Rest, Visited, Exits)
                          end;
                        false ->
                          nearest_exit_helper(Maze, Rows, Cols, Rest, Visited, Exits)
                      end;
                    false ->
                      nearest_exit_helper(Maze, Rows, Cols, Rest, Visited, Exits)
                  end
            end;
        false ->
            Neighbors = get_neighbors(Current, Rows, Cols),
            ValidNeighbors = [N || N <- Neighbors,
                              is_valid_move(N, Maze, Visited)],
            NewQueue = Rest ++ lists:map(fun(N) -> {N, Distance + 1} end, ValidNeighbors),
            NewVisited = lists:foldl(fun(N, Acc) -> sets:add_element(N, Acc) end, Visited, ValidNeighbors),
            nearest_exit_helper(Maze, Rows, Cols, NewQueue, NewVisited, Exits)
    end.

get_neighbors({Row, Col}, Rows, Cols) ->
    [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}].

is_valid_move({Row, Col}, Maze, Visited) ->
    Rows = length(Maze),
    Cols = length(Maze[0]),
    Row >= 0 andalso Row < Rows andalso Col >= 0 andalso Col < Cols andalso
    Maze[Row+1][Col+1] == '.' andalso
    not sets:is_element({Row, Col}, Visited).

is_valid_exit({Row, Col}, Rows, Cols) ->
  Row == 0 orelse Row == Rows - 1 orelse Col == 0 orelse Col == Cols - 1.