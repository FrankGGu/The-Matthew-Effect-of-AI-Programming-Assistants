-module(move_zeroes).
-export([move_zeroes/1]).

move_zeroes(Nums) ->
  move_zeroes_helper(Nums, 0, 0).

move_zeroes_helper(Nums, Read, Write) when Read == length(Nums) ->
  fill_zeros(Nums, Write);
move_zeroes_helper(Nums, Read, Write) ->
  case lists:nth(Read + 1, Nums) of
    0 ->
      move_zeroes_helper(Nums, Read + 1, Write);
    Val ->
      {NewNums, _} = lists:replace(Write + 1, Val, Nums),
      move_zeroes_helper(NewNums, Read + 1, Write + 1)
  end.

fill_zeros(Nums, Write) when Write == length(Nums) ->
  Nums;
fill_zeros(Nums, Write) ->
  {NewNums, _} = lists:replace(Write + 1, 0, Nums),
  fill_zeros(NewNums, Write + 1).