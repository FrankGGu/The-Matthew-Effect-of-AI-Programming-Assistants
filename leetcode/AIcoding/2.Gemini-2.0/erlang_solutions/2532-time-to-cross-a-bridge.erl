-module(time_to_cross).
-export([total_time/2]).

total_time(N, Times) ->
  total_time(N, Times, [], []).

total_time(0, _Times, Left, Right) ->
  case Left of
    [] ->
      0;
    _ ->
      MaxTime = lists:max([First, Second || {First, Second} <- Left]),
      MaxTime
  end;

total_time(N, [A, B, C, D], Left, Right) ->
  total_time(N, [A, B, C, D], Left, Right, 0).

total_time(N, [A, B, C, D], Left, Right, Time) ->
  if
    N > 0 ->
      {Fast1, Fast2, RemainingLeft, RemainingRight, NewTime} = move_to_right(N, [A, B, C, D], Left, Right, Time),
      total_time(0, [A, B, C, D], RemainingLeft, [{Fast1, Fast2} | RemainingRight], NewTime);
    true ->
      Time
  end.

move_to_right(N, [A, B, C, D], Left, Right, Time) ->
  if
    N =:= 1 ->
      {A, A, Left, Right, Time + A + A};
    N =:= 2 ->
      {A, B, Left, Right, Time + B + A};
    true ->
      if
        length(Left) > 0 ->
          {Fast1, Fast2} = get_fastest_pair(Left),
          move_back_to_left(N, [A, B, C, D], Left -- [{Fast1, Fast2}], [{Fast1, Fast2} | Right], Time + Fast2);
        true ->
          move_back_to_left(N, [A, B, C, D], lists:seq(1, N - 2), [{1, 2} | Right], Time + B)
      end
  end.

move_back_to_left(N, [A, B, C, D], Left, Right, Time) ->
  if
    length(Right) > 0 ->
      Fastest = get_fastest(Right),
      {Fastest, Fastest, Left ++ [{N - 1, N}], lists:delete(Fastest, Right), Time + Fastest};
    true ->
      {0, 0, Left, Right, Time}
  end.

get_fastest([{A, _} | T]) ->
  get_fastest(T, A).

get_fastest([], Fastest) ->
  Fastest;
get_fastest([{A, _} | T], Fastest) ->
  if
    A < Fastest ->
      get_fastest(T, A);
    true ->
      get_fastest(T, Fastest)
  end.

get_fastest_pair([{A, B} | T]) ->
  get_fastest_pair(T, {A, B}).

get_fastest_pair([], {A, B}) ->
  {A, B};
get_fastest_pair([{A, B} | T], {FastA, FastB}) ->
  if
    B < FastB ->
      get_fastest_pair(T, {A, B});
    true ->
      get_fastest_pair(T, {FastA, FastB})
  end.