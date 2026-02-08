-module(solution).
-export([sortColors/1]).

sortColors(Nums) ->
    sort_and_collect(Nums, [], [], []).

sort_and_collect([], ZerosAcc, OnesAcc, TwosAcc) ->
    lists:reverse(ZerosAcc) ++ lists:reverse(OnesAcc) ++ lists:reverse(TwosAcc);
sort_and_collect([0|T], ZerosAcc, OnesAcc, TwosAcc) ->
    sort_and_collect(T, [0|ZerosAcc], OnesAcc, TwosAcc);
sort_and_collect([1|T], ZerosAcc, OnesAcc, TwosAcc) ->
    sort_and_collect(T, ZerosAcc, [1|OnesAcc], TwosAcc);
sort_and_collect([2|T], ZerosAcc, OnesAcc, TwosAcc) ->
    sort_and_collect(T, ZerosAcc, OnesAcc, [2|TwosAcc]).