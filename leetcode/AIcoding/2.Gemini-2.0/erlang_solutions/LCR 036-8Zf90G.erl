-module(evalRPN).
-export([evalRPN/1]).

evalRPN(Tokens) ->
  evalRPN_helper(Tokens, []).

evalRPN_helper([], [Result]) ->
  Result;
evalRPN_helper([Token|Rest], Stack) ->
  case Token of
    "+" ->
      [Num2, Num1 | NewStack] = Stack,
      evalRPN_helper(Rest, [Num1 + Num2 | NewStack]);
    "-" ->
      [Num2, Num1 | NewStack] = Stack,
      evalRPN_helper(Rest, [Num1 - Num2 | NewStack]);
    "*" ->
      [Num2, Num1 | NewStack] = Stack,
      evalRPN_helper(Rest, [Num1 * Num2 | NewStack]);
    "/" ->
      [Num2, Num1 | NewStack] = Stack,
      evalRPN_helper(Rest, [trunc(Num1 / Num2) | NewStack]);
    Num ->
      evalRPN_helper(Rest, [list_to_integer(Num) | Stack])
  end.