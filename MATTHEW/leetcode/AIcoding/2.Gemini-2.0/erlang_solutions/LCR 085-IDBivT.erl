-module(generate_parentheses).
-export([generate_parenthesis/1]).

generate_parenthesis(N) ->
  generate(N, N, "").

generate(0, 0, Acc) ->
  [Acc];
generate(Left, Right, Acc) when Left > Right ->
  [];
generate(Left, Right, Acc) when Left < 0 or Right < 0 ->
  [];
generate(Left, Right, Acc) ->
  generate(Left - 1, Right, Acc ++ "(") ++ generate(Left, Right - 1, Acc ++ ")").