-module(solution).
-export([addTwoNumbers/2]).

addTwoNumbers(L1, L2) ->
    addTwoNumbers_helper(L1, L2, 0).

addTwoNumbers_helper(nil, nil, 0) ->
    nil;
addTwoNumbers_helper(L1, L2, Carry) ->
    Val1 = case L1 of
               nil -> 0;
               {V, _N} -> V
           end,
    Val2 = case L2 of
               nil -> 0;
               {V, _N} -> V
           end,

    Sum = Val1 + Val2 + Carry,

    NewCarry = Sum div 10,
    Digit = Sum rem 10,

    NextL1 = case L1 of
                 nil -> nil;
                 {_V, N} -> N
             end,
    NextL2 = case L2 of
                 nil -> nil;
                 {_V, N} -> N
             end,

    NextNode = addTwoNumbers_helper(NextL1, NextL2, NewCarry),

    {Digit, NextNode}.