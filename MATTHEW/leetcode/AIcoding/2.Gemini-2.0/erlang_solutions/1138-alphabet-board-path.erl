-module(alphabet_board_path).
-export([alphabet_board_path/1]).

alphabet_board_path(Target) ->
  alphabet_board_path(Target, {0, 0}, []).

alphabet_board_path([], {X, Y}, Acc) ->
  lists:reverse(Acc);
alphabet_board_path([H|T], {X1, Y1}, Acc) ->
  {X2, Y2} = char_to_coord(H),
  DiffX = X2 - X1,
  DiffY = Y2 - Y1,
  Path = generate_path(DiffX, DiffY, {X1, Y1}, {X2, Y2}),
  alphabet_board_path(T, {X2, Y2}, Acc ++ Path).

char_to_coord(Char) ->
  Pos = Char - $a,
  {Pos rem 5, Pos div 5}.

generate_path(DiffX, DiffY, {X1, Y1}, {X2, Y2}) ->
  case {DiffX, DiffY} of
    {0, 0} -> [!];
    {0, Y} when Y > 0 -> lists:duplicate(Y, $R);
    {0, Y} when Y < 0 -> lists:duplicate(abs(Y), $L);
    {X, 0} when X > 0 -> lists:duplicate(X, $D);
    {X, 0} when X < 0 -> lists:duplicate(abs(X), $U);
    {X, Y} when X > 0, Y > 0 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X > 0, Y < 0 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $L);
    {X, Y} when X < 0, Y > 0 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X < 0, Y < 0 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $L);
    {X, Y} when X > 0, X1 =:= 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $D);
    {X, Y} when X < 0, X2 =:= 0, Y2 =:= 4 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $U);

    {X, Y} when X > 0, X1 =:= 0, Y1 =:= 0 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X < 0, X2 =:= 0, Y2 =:= 0 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);

    {X, Y} when X > 0, X2 =:= 0, Y2 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $D);
    {X, Y} when X < 0, X2 =:= 0, Y2 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $U);

    {X, Y} when X > 0, X1 =:= 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $D);
    {X, Y} when X < 0, X1 =:= 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $U);

    {X, Y} when X < 0, X2 =:= 4, Y2 =:= 0 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X > 0, X2 =:= 4, Y2 =:= 0 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $R);

    {X, Y} when X < 0, X1 =:= 4, Y1 =:= 0 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X > 0, X1 =:= 4, Y1 =:= 0 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $R);

    {X, Y} when X < 0, X2 =:= 4, Y2 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $L);
    {X, Y} when X > 0, X2 =:= 4, Y2 =:= 4 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $L);

    {X, Y} when X < 0, X1 =:= 4, Y1 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $L);
    {X, Y} when X > 0, X1 =:= 4, Y1 =:= 4 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $L);
    {X, Y} when X1 =:= 4 ,Y > 0 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X1 =:= 4 ,Y < 0 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X2 =:= 4 ,Y > 0 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X2 =:= 4 ,Y < 0 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X < 0, Y > 0, X1 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X < 0, Y > 0, X2 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $R);
    {X, Y} when X < 0, Y < 0, X1 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $L);
     {X, Y} when X < 0, Y < 0, X2 =:= 4 -> lists:duplicate(abs(X), $U) ++ lists:duplicate(abs(Y), $L);

     {X, Y} when X > 0, Y > 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $D);
     {X, Y} when X > 0, Y < 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $D);

    {X, Y} when X < 0, Y > 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $R) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X < 0, Y < 0, Y1 =:= 4 -> lists:duplicate(abs(Y), $L) ++ lists:duplicate(abs(X), $U);
    {X, Y} when X > 0, Y > 0, X1 =:= 4 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $R);
     {X, Y} when X > 0, Y < 0, X1 =:= 4 -> lists:duplicate(abs(X), $D) ++ lists:duplicate(abs(Y), $L);

    {X, Y} when X < 0, Y > 0, X1 =:=