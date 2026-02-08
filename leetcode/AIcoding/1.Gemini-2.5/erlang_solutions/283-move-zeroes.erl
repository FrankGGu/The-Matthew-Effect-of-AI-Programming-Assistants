-module(solution).
-export([move_zeroes/1]).

move_zeroes(Nums) ->
    move_zeroes_acc(Nums, [], 0).

move_zeroes_acc([], NonZeroes, ZeroCount) ->
    lists:reverse(NonZeroes) ++ lists:duplicate(ZeroCount, 0);
move_zeroes_acc([0 | T], NonZeroes, ZeroCount) ->
    move_zeroes_acc(T, NonZeroes, ZeroCount + 1);
move_zeroes_acc([H | T], NonZeroes, ZeroCount) ->
    move_zeroes_acc(T, [H | NonZeroes], ZeroCount).