-module(swim_in_rising_water).
-export([swim_in_rising_water/1]).

swim_in_rising_water(Grid) ->
  N = length(Grid),
  {_, Result} = solve(Grid, N),
  Result.

solve(Grid, N) ->
  PriorityQueue = gb_sets:empty(),
  gb_sets:add({Grid[1][1], {1, 1}}, PriorityQueue),
  Visited = sets:new(),
  solve_helper(Grid, N, PriorityQueue, Visited, 0).

solve_helper(Grid, N, PriorityQueue, Visited, MaxHeight) ->
  case gb_sets:is_empty(PriorityQueue) of
    true ->
      {Visited, MaxHeight};
    false ->
      {{Height, {Row, Col}}, RestQueue} = gb_sets:take_smallest(PriorityQueue),
      case sets:is_element({Row, Col}, Visited) of
        true ->
          solve_helper(Grid, N, RestQueue, Visited, MaxHeight);
        false ->
          NewMaxHeight = max(MaxHeight, Height),
          NewVisited = sets:add({Row, Col}, Visited),
          case Row == N andalso Col == N of
            true ->
              {NewVisited, NewMaxHeight};
            false ->
              Neighbors = get_neighbors(Row, Col, N),
              NewPriorityQueue = lists:foldl(
                fun({NewRow, NewCol}, AccPriorityQueue) ->
                  case sets:is_element({NewRow, NewCol}, NewVisited) of
                    true ->
                      AccPriorityQueue;
                    false ->
                      gb_sets:add({Grid[NewRow][NewCol], {NewRow, NewCol}}, AccPriorityQueue)
                  end
                end,
                RestQueue,
                Neighbors
              ),
              solve_helper(Grid, N, NewPriorityQueue, NewVisited, NewMaxHeight)
          end
      end
  end.

get_neighbors(Row, Col, N) ->
  lists:filter(
    fun({R, C}) ->
      R >= 1 andalso R <= N andalso C >= 1 andalso C <= N
    end,
    [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}]
  ).