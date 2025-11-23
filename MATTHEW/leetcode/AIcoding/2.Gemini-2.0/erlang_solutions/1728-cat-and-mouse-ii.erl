-module(cat_mouse_ii).
-export([can_mouse_win/6]).

can_mouse_win(Grid, MouseJump, CatJump, MousePos, CatPos, FoodPos) ->
  Rows = length(Grid),
  Cols = length(lists:nth(1, Grid)),
  MaxTurns = Rows * Cols * 2,
  memo(MousePos, CatPos, 0, Grid, MouseJump, CatJump, FoodPos, MaxTurns, #{}).

memo(MousePos, CatPos, Turns, Grid, MouseJump, CatJump, FoodPos, MaxTurns, Memo) ->
  case maps:get({MousePos, CatPos, Turns}, Memo, undefined) of
    undefined ->
      Result = solve(MousePos, CatPos, Turns, Grid, MouseJump, CatJump, FoodPos, MaxTurns, Memo),
      maps:put({MousePos, CatPos, Turns}, Result, Memo);
    Result ->
      Result
  end.

solve(MousePos, CatPos, Turns, Grid, MouseJump, CatJump, FoodPos, MaxTurns, Memo) ->
  Rows = length(Grid),
  Cols = length(lists:nth(1, Grid)),
  {MX, MY} = MousePos,
  {CX, CY} = CatPos,
  {FX, FY} = FoodPos,

  case Turns rem 2 of
    0 -> % Mouse's turn
      if MX == FX and MY == FY ->
        true;
      MX == CX and MY == CY ->
        false;
      Turns > MaxTurns ->
        false;
      true ->
        MouseMoves = get_possible_moves(MousePos, MouseJump, Grid),
        lists:any(
          fun(NextMousePos) ->
            not (memo(NextMousePos, CatPos, Turns + 1, Grid, MouseJump, CatJump, FoodPos, MaxTurns, Memo))
          end,
          MouseMoves)
      end;
    1 -> % Cat's turn
      if MX == CX and MY == CY ->
        false;
      CX == FX and CY == FY ->
        false;
      Turns > MaxTurns ->
        false;
      true ->
        CatMoves = get_possible_moves(CatPos, CatJump, Grid),
        lists:all(
          fun(NextCatPos) ->
            memo(MousePos, NextCatPos, Turns + 1, Grid, MouseJump, CatJump, FoodPos, MaxTurns, Memo)
          end,
          CatMoves)
      end
  end.

get_possible_moves({X, Y}, Jump, Grid) ->
  Rows = length(Grid),
  Cols = length(lists:nth(1, Grid)),
  ValidMoves = [],

  PossibleMoves = [{X, Y} | lists:flatten([
    [
      lists:map(
        fun(I) ->
          {X + I, Y}
        end,
        lists:seq(1, Jump)
      ),
      lists:map(
        fun(I) ->
          {X - I, Y}
        end,
        lists:seq(1, Jump)
      ),
      lists:map(
        fun(I) ->
          {X, Y + I}
        end,
        lists:seq(1, Jump)
      ),
      lists:map(
        fun(I) ->
          {X, Y - I}
        end,
        lists:seq(1, Jump)
      )
    ]
  ])],

  lists:foldl(
    fun(Move, Acc) ->
      {NX, NY} = Move,
      if NX >= 1 and NX =< Cols and NY >= 1 and NY =< Rows and lists:nth(NY, Grid) !! NX =/= '#' ->
        [Move | Acc];
      true ->
        Acc
      end
    end,
    ValidMoves,
    PossibleMoves
  ).