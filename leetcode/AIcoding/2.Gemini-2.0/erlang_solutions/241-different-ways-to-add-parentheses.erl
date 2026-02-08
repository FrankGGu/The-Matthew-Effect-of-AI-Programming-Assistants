-module(different_ways_to_add_parentheses).
-export([diffWaysToCompute/1]).

diffWaysToCompute(Expression) ->
  parse_and_evaluate(Expression).

parse_and_evaluate(Expression) ->
  case string:to_integer(Expression) of
    {Int, _} ->
      [Int];
    _ ->
      lists:foldl(
        fun(I, Acc) ->
          case lists:nth(I, string:to_charlist(Expression)) of
            '+' ->
              Left = parse_and_evaluate(string:substr(Expression, 1, I - 1)),
              Right = parse_and_evaluate(string:substr(Expression, I + 1, length(Expression))),
              Acc ++ [L + R || L <- Left, R <- Right];
            '-' ->
              Left = parse_and_evaluate(string:substr(Expression, 1, I - 1)),
              Right = parse_and_evaluate(string:substr(Expression, I + 1, length(Expression))),
              Acc ++ [L - R || L <- Left, R <- Right];
            '*' ->
              Left = parse_and_evaluate(string:substr(Expression, 1, I - 1)),
              Right = parse_and_evaluate(string:substr(Expression, I + 1, length(Expression))),
              Acc ++ [L * R || L <- Left, R <- Right];
            _ ->
              Acc
          end
        end,
        [],
        lists:seq(1, length(Expression) - 1)
      )
  end.