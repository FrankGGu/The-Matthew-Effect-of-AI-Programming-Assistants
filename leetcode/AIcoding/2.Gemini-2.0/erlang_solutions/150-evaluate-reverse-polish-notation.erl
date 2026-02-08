-module(rpn).
-export([eval_rpn/1]).

eval_rpn(Tokens) ->
  eval_rpn_helper(Tokens, []).

eval_rpn_helper([], [Result]) ->
  Result;
eval_rpn_helper([Token | Rest], Stack) ->
  case Token of
    "+" ->
      [A, B | NewStack] = lists:reverse(Stack),
      eval_rpn_helper(Rest, [A + B | NewStack]);
    "-" ->
      [A, B | NewStack] = lists:reverse(Stack),
      eval_rpn_helper(Rest, [A - B | NewStack]);
    "*" ->
      [A, B | NewStack] = lists:reverse(Stack),
      eval_rpn_helper(Rest, [A * B | NewStack]);
    "/" ->
      [A, B | NewStack] = lists:reverse(Stack),
      eval_rpn_helper(Rest, trunc(A / B)  | NewStack]);
    _ ->
      eval_rpn_helper(Rest, [list_to_integer(Token) | Stack])
  end.