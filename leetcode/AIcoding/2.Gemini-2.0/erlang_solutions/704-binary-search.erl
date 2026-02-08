-module(binary_search).
-export([search/2]).

search(Nums, Target) ->
  search_helper(Nums, Target, 0, length(Nums) - 1).

search_helper(Nums, Target, Low, High) ->
  if Low > High ->
    -1;
  true ->
    Mid = Low + (High - Low) div 2,
    case Nums !! Mid of
      Target ->
        Mid;
      Value when Value < Target ->
        search_helper(Nums, Target, Mid + 1, High);
      _ ->
        search_helper(Nums, Target, Low, Mid - 1)
    end
  end.