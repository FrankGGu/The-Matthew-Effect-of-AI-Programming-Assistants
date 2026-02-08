-module(count_integers).
-export([count_integers/3]).

count_integers(Num1, Num2, MaxSum) ->
  count_integers_helper(Num2, MaxSum) - count_integers_helper(Num1 - 1, MaxSum).

count_integers_helper(Num, MaxSum) ->
  lists:sum([helper(length(integer_to_list(Num)), MaxSum, I, memo()) || I <- lists:seq(1, 9)]).

helper(Len, MaxSum, StartDigit, Memo) ->
  helper(Len, MaxSum, StartDigit, 1, Memo).

helper(Len, MaxSum, CurrentSum, Position, Memo) ->
  case {Len, MaxSum, CurrentSum, Position} of
    {Len, MaxSum, CurrentSum, Position} when Position > Len ->
      case CurrentSum =< MaxSum of
        true -> 1;
        false -> 0
      end;
    {Len, MaxSum, CurrentSum, Position} when CurrentSum > MaxSum ->
      0;
    {Len, MaxSum, CurrentSum, Position} ->
      case Memo:get({Len, MaxSum, CurrentSum, Position}, undefined) of
        undefined ->
          Sum = lists:sum([helper(Len, MaxSum, CurrentSum + I, Position + 1, Memo) || I <- lists:seq(0, 9)]),
          Memo1 = Memo:put({Len, MaxSum, CurrentSum, Position}, Sum),
          Sum;
        Val ->
          Val
      end
  end.

memo() -> dict:new().