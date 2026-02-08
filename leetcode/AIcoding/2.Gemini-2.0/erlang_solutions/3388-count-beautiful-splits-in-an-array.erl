-module(beautiful_splits).
-export([count_beautiful_splits/1]).

count_beautiful_splits(Nums) ->
  count_beautiful_splits(Nums, 0).

count_beautiful_splits(Nums, Acc) ->
  Len = length(Nums),
  count_beautiful_splits(Nums, 1, Len - 1, Acc).

count_beautiful_splits(_Nums, I, J, Acc) when I > J ->
  Acc;
count_beautiful_splits(Nums, I, J, Acc) ->
  {Prefix, Suffix} = lists:split(I, Nums),
  PrefixSet = sets:from_list(Prefix),
  SuffixSet = sets:from_list(Suffix),
  case sets:size(PrefixSet) == sets:size(SuffixSet) of
    true ->
      count_beautiful_splits(Nums, I + 1, J, Acc + 1);
    false ->
      count_beautiful_splits(Nums, I + 1, J, Acc)
  end.