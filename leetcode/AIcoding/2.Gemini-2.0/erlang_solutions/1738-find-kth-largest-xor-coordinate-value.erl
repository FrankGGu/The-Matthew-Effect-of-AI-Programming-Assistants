-module(kth_largest_xor).
-export([kth_largest_xor/2]).

kth_largest_xor(Matrix, K) ->
  Rows = length(Matrix),
  Cols = length(lists:nth(1, Matrix)),
  PrefixXor = array:new([Rows, Cols], 0),

  lists:foreach(fun(I) ->
    lists:foreach(fun(J) ->
      Val = lists:nth(J, lists:nth(I, Matrix)),
      PrevXor = case I == 1 of
        true -> 0;
        false -> array:get({I-1, J-1}, PrefixXor)
      end,
      LeftXor = case J == 1 of
        true -> 0;
        false -> array:get({I, J-1}, PrefixXor)
      end,
      TopLeftXor = case {I == 1, J == 1} of
        {true, true} -> 0;
        {true, false} -> 0;
        {false, true} -> 0;
        {false, false} -> array:get({I-1, J-1-1}, PrefixXor)
      end,
      array:set({I, J}, PrevXor bxor LeftXor bxor TopLeftXor bxor Val, PrefixXor)
    end, lists:seq(1, Cols))
  end, lists:seq(1, Rows)),

  Xors = lists:sort(fun(A, B) -> A > B end, [array:get({I, J}, PrefixXor) || I <- lists:seq(1, Rows), J <- lists:seq(1, Cols)]),
  lists:nth(K, Xors).