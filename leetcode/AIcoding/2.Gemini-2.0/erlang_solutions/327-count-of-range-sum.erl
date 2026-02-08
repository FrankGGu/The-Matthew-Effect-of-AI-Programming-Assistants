-module(count_range_sum).
-export([count_range_sum/3]).

count_range_sum(Nums, Lower, Upper) ->
  PrefixSums = prefix_sums(Nums),
  count_ranges(PrefixSums, Lower, Upper).

prefix_sums(Nums) ->
  prefix_sums(Nums, 0, []).

prefix_sums([], Acc, AccList) ->
  lists:reverse([Acc | AccList]);
prefix_sums([H | T], Acc, AccList) ->
  prefix_sums(T, Acc + H, [Acc | AccList]).

count_ranges(PrefixSums, Lower, Upper) ->
  count_ranges(PrefixSums, Lower, Upper, 0).

count_ranges([], _, _, Count) ->
  Count;
count_ranges([H | T], Lower, Upper, Count) ->
  NewCount = count_valid_ranges(T, H, Lower, Upper, 0),
  count_ranges(T, Lower, Upper, Count + NewCount).

count_valid_ranges([], _, _, _, Count) ->
  Count;
count_valid_ranges([H | T], PrefixSum, Lower, Upper, Count) ->
  Diff = H - PrefixSum,
  NewCount = case Diff >= Lower and Diff =< Upper of
    true -> Count + 1;
    false -> Count
  end,
  count_valid_ranges(T, PrefixSum, Lower, Upper, NewCount).