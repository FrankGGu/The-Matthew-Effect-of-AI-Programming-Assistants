-module(valid_move_combinations).
-export([number_of_combinations/2]).

number_of_combinations(Pieces, Moves) ->
  N = length(Pieces),
  number_of_combinations(Pieces, Moves, N).

number_of_combinations(Pieces, Moves, N) ->
  number_of_combinations(Pieces, Moves, N, 0, []).

number_of_combinations(_Pieces, _Moves, N, Count, []) when N =:= 0 ->
  Count + 1;
number_of_combinations(Pieces, Moves, N, Count, Acc) ->
  lists:foldl(
    fun(I, AccCount) ->
      NewAcc = [I | Acc],
      number_of_combinations(Pieces, Moves, N - 1, AccCount, NewAcc)
    end,
    Count,
    lists:seq(1, length(Moves))
  ).

number_of_combinations(Pieces, Moves, 0, Count, Acc) ->
  check_combinations(Pieces, Moves, lists:reverse(Acc), Count).

check_combinations(Pieces, Moves, Indices, Count) ->
  {ok, Pid} = spawn_monitor(fun() -> check_combinations_process(Pieces, Moves, Indices) end),
  receive
    {'DOWN', _, _, _, Result} ->
      case Result of
        valid ->
          Count + 1;
        invalid ->
          Count
      end
  after 5000 ->
    exit(Pid, timeout),
    Count
  end.

check_combinations_process(Pieces, Moves, Indices) ->
  N = length(Pieces),
  Valid = check_combinations_recursive(Pieces, Moves, Indices, N, []),
  case Valid of
    true ->
      exit(valid);
    false ->
      exit(invalid)
  end.

check_combinations_recursive(_Pieces, _Moves, _Indices, 0, _Positions) ->
  true;
check_combinations_recursive(Pieces, Moves, Indices, K, Positions) ->
  I = lists:nth(K, Indices),
  Move = lists:nth(I, Moves),
  Piece = lists:nth(K, Pieces),
  case simulate_move(Piece, Move, Positions) of
    {ok, NewPositions} ->
      check_combinations_recursive(Pieces, Moves, Indices, K - 1, NewPositions);
    error ->
      false
  end.

simulate_move(Piece, Move, Positions) ->
  {X0, Y0} = Piece,
  {DX, DY} = Move,
  case is_valid_move(X0, Y0, DX, DY, Positions) of
    true ->
      {ok, [{X0 + DX, Y0 + DY} | Positions]};
    false ->
      error
  end.

is_valid_move(X0, Y0, DX, DY, Positions) ->
  X = X0 + DX,
  Y = Y0 + DY,
  case is_occupied(X, Y, Positions) of
    true ->
      false;
    false ->
      case is_within_bounds(X, Y) of
        true ->
          true;
        false ->
          false
      end
  end.

is_occupied(X, Y, Positions) ->
  lists:member({X, Y}, Positions).

is_within_bounds(X, Y) ->
  X >= 1 andalso X =< 8 andalso Y >= 1 andalso Y =< 8.