-module(escape_the_large_maze).
-export([is_escape_possible/3]).

is_escape_possible(Blocked, Source, Target) ->
  MaxArea = length(Blocked),
  is_escape_possible_helper(Blocked, Source, Target, MaxArea) andalso
  is_escape_possible_helper(Blocked, Target, Source, MaxArea).

is_escape_possible_helper(Blocked, Start, End, MaxArea) ->
  Visited = sets:new(),
  Queue = queue:new(),
  Queue1 = queue:in(Start, Queue),
  is_escape_possible_bfs(Blocked, End, MaxArea, sets:add_element(Start, Visited), Queue1, 0).

is_escape_possible_bfs(_Blocked, _End, _MaxArea, _Visited, Queue, Count) when Count > 20000 ->
  true;
is_escape_possible_bfs(_Blocked, _End, _MaxArea, _Visited, Queue, _Count) when queue:is_empty(Queue) ->
  false;
is_escape_possible_bfs(Blocked, End, MaxArea, Visited, Queue, Count) ->
  {Value, Queue1} = queue:out(Queue),
  {ok, Current} = Value,
  {X, Y} = Current,

  case Current =:= End of
    true -> true;
    false ->
      Neighbors = [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
      ValidNeighbors = lists:filter(fun({NX, NY}) ->
                                          NX >= 0 and NX < 1000000 and
                                          NY >= 0 and NY < 1000000 and
                                          not lists:member({NX, NY}, Blocked) and
                                          not sets:is_element({NX, NY}, Visited)
                                      end, Neighbors),
      NewVisited = lists:foldl(fun(N, Acc) -> sets:add_element(N, Acc) end, Visited, ValidNeighbors),
      NewQueue = lists:foldl(fun(N, Acc) -> queue:in(N, Acc) end, Queue1, ValidNeighbors),
      is_escape_possible_bfs(Blocked, End, MaxArea, NewVisited, NewQueue, Count + 1)
  end.