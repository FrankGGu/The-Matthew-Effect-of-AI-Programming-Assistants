-module(max_value_of_equation).
-export([max_value_of_equation/2]).

max_value_of_equation(Points, K) ->
  max_value_of_equation(Points, K, -infinity).

max_value_of_equation([], _, MaxVal) ->
  MaxVal;
max_value_of_equation([H|T], K, MaxVal) ->
  max_value_of_equation(T, K, process_point(H, T, K, MaxVal)).

process_point(_, [], _, MaxVal) ->
  MaxVal;
process_point([X1, Y1], [H|T], K, MaxVal) ->
  [X2, Y2] = H,
  Diff = X2 - X1,
  case Diff =< K of
    true ->
      Val = Y1 + Y2 + Diff,
      NewMaxVal = max(MaxVal, Val),
      process_point([X1, Y1], T, K, NewMaxVal);
    false ->
      MaxVal
  end.

max(A, B) ->
  if A > B -> A; true -> B end.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

max_value_of_equation_test() ->
  [?_assertEqual(4, max_value_of_equation([[1,3],[2,0],[5,10],[6,-10]], 1)),
   ?_assertEqual(4, max_value_of_equation([[0,0],[3,0],[9,2]], 3))
  ].
-endif.