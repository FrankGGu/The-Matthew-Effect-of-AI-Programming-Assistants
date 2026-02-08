-module(integer_break).
-export([integerBreak/1]).

integerBreak(N) ->
  case N of
    1 -> 0;
    2 -> 1;
    3 -> 2;
    _ ->
      F = fun(N) ->
        case N of
          0 -> 1;
          1 -> 1;
          2 -> 2;
          3 -> 3;
          _ ->
            max(3 * F(N - 3), 2 * F(N - 2))
        end
      end,
      F(N)
  end.