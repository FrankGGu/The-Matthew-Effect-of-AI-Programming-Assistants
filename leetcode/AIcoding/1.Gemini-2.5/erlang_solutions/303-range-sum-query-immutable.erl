-module(num_array).
-export([init/1, sumRange/3]).

init(Nums) ->
    calculate_prefix_sums(Nums, 0, []).

calculate_prefix_sums([], AccSum, AccList) ->
    lists:reverse([AccSum | AccList]);
calculate_prefix_sums([H|T], AccSum, AccList) ->
    NewAccSum = AccSum + H,
    calculate_prefix_sums(T, NewAccSum, [AccSum | AccList]).

sumRange(PrefixSums, Left, Right) ->
    P_RightPlus1 = lists:nth(Right + 1 + 1, PrefixSums),
    P_Left = lists:nth(Left + 1, PrefixSums),
    P_RightPlus1 - P_Left.