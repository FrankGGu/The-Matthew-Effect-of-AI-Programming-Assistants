-module(drone_formation).
-export([solve/1]).

solve(grid) ->
  N = length(grid),
  M = length(hd(grid)),
  {Ones, Zeros} = lists:foldl(
    fun(Row, {O, Z}) ->
      lists:foldl(
        fun(Val, {Oi, Zi}) ->
          case Val of
            1 -> {Oi + 1, Zi};
            0 -> {Oi, Zi + 1}
          end
        end,
        {O, Z},
        Row
      )
    end,
    {0, 0},
    grid
  ),
  min(Ones, Zeros).