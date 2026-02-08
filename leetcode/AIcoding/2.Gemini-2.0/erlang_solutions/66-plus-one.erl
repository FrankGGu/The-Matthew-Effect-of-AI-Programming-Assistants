-module(plus_one).
-export([plus_one/1]).

plus_one(Digits) ->
  plus_one_helper(Digits, 1).

plus_one_helper([], Carry) ->
  case Carry of
    0 -> [];
    1 -> [1]
  end;
plus_one_helper([H|T], Carry) ->
  Sum = H + Carry,
  Digit = Sum rem 10,
  NewCarry = Sum div 10,
  [Digit | plus_one_helper(T, NewCarry)].

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

plus_one_test() ->
  [?_assertEqual([1,2,4], plus_one([1,2,3])),
   ?_assertEqual([4,3,2,2], plus_one([4,3,2,1])),
   ?_assertEqual([1], plus_one([0])),
   ?_assertEqual([1,0], plus_one([9])),
   ?_assertEqual([1,0,0], plus_one([9,9])),
   ?_assertEqual([1,0,0,0], plus_one([9,9,9]))
  ].
-endif.