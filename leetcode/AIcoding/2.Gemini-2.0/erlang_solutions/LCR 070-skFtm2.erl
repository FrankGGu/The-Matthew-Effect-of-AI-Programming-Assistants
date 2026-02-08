-module(single_element).
-export([single_non_duplicate/1]).

single_non_duplicate(Nums) ->
  single_non_duplicate(Nums, 0, length(Nums) - 1).

single_non_duplicate(Nums, Low, High) when Low > High ->
  undefined;
single_non_duplicate(Nums, Low, High) ->
  Mid = Low + (High - Low) div 2,
  if Mid rem 2 == 0 ->
    if Mid + 1 <= High andalso lists:nth(Mid + 1, Nums) == lists:nth(Mid + 1 + (-1), Nums) ->
      single_non_duplicate(Nums, Mid + 2, High);
    else
      single_non_duplicate(Nums, Low, Mid - 1)
    else
    if Mid - 1 >= Low andalso lists:nth(Mid + 1 + (-1), Nums) == lists:nth(Mid + 1 + (-2), Nums) ->
      single_non_duplicate(Nums, Mid + 1, High);
    else
      single_non_duplicate(Nums, Low, Mid - 1)
  end,
  case Low > High of
    true ->
      case Low of
        _ when Low < length(Nums) ->
          lists:nth(Low+1, Nums);
        _ ->
          lists:nth(High+1, Nums)
      end;
    false ->
      lists:nth(Low+1, Nums)
  end.