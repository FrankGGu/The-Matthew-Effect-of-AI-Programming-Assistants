-module(infinite_chess).
-export([can_reach/4]).

can_reach(board, start, target, max_moves) ->
    queue:bfs(
      [start],
      fun(Pos) ->
          case Pos of
              {X, Y} ->
                  Neighbors = get_neighbors(board, X, Y),
                  lists:filter(
                    fun({NX, NY}) ->
                        NX >= 0 andalso NY >= 0 andalso NX < 201 andalso NY < 201
                    end,
                    Neighbors
                  );
              _ -> []
          end
      end,
      fun(Pos) -> Pos == target end,
      max_moves
    ).

get_neighbors(board, X, Y) ->
    Obstacles = get_obstacles(board),
    [{NX, NY} || DX <- [-1, 0, 1],
                DY <- [-1, 0, 1],
                (DX /= 0 orelse DY /= 0),
                NX = X + DX,
                NY = Y + DY,
                not lists:member({NX, NY}, Obstacles)].

get_obstacles(board) ->
    lists:foldl(
      fun({X, Y}, Acc) ->
          [ {X + 100, Y + 100} | Acc ]
      end,
      [],
      board
    ).

-module(queue).
-export([bfs/4]).

bfs(StartNodes, GetNeighbors, IsTarget, MaxMoves) ->
    bfs(StartNodes, GetNeighbors, IsTarget, MaxMoves, 0, [], []).

bfs([], _, _, _, _, Visited, _) ->
    false;
bfs(_, _, _, MaxMoves, CurrentMoves, _, _) when CurrentMoves > MaxMoves ->
    false;
bfs([Node | Rest], GetNeighbors, IsTarget, MaxMoves, CurrentMoves, Visited, Q) ->
    case lists:member(Node, Visited) of
        true ->
            bfs(Rest, GetNeighbors, IsTarget, MaxMoves, CurrentMoves, Visited, Q);
        false ->
            case IsTarget(Node) of
                true ->
                    true;
                false ->
                    Neighbors = GetNeighbors(Node),
                    NewNeighbors = lists:filter(
                        fun(N) -> not lists:member(N, Visited) end,
                        Neighbors
                    ),
                    bfs(Rest ++ NewNeighbors, GetNeighbors, IsTarget, MaxMoves, CurrentMoves + 1, [Node | Visited], Q ++ NewNeighbors)
            end
    end.