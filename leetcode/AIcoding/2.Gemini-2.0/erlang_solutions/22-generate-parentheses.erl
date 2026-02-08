-module(generate_parentheses).
-export([generate_parenthesis/1]).

generate_parenthesis(N) ->
  generate(N, N, "").

generate(0, 0, Acc) ->
  [lists:reverse(Acc)];
generate(Open, Close, Acc) when Open > Close ->
  [];
generate(Open, Close, Acc) when Open > 0 ->
  generate(Open - 1, Close, "(":Acc) ++ generate(Open, Close - 1, ")":Acc);
generate(0, Close, Acc) when Close > 0 ->
  generate(0, Close - 1, ")":Acc);
generate(_, _, _) ->
  [].