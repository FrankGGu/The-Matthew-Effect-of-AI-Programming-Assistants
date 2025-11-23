-module(minimum_index_of_a_valid_split).
-export([minimum_index/1]).

minimum_index(Nums) ->
  minimum_index(Nums, 0, length(Nums) - 1).

minimum_index(Nums, L, R) ->
  case L > R orelse length(Nums) < 2 of
    true -> -1;
    false ->
      TotalCount = count_elements(Nums, lists:seq(L, R));
      minimum_index_helper(Nums, L, R, TotalCount)
  end.

minimum_index_helper(Nums, L, R, TotalCount) ->
  minimum_index_helper(Nums, L, R, TotalCount, 0, []).

minimum_index_helper(Nums, L, R, TotalCount, Index, Acc) ->
  case Index >= R of
    true -> -1;
    false ->
      NewAcc = [lists:nth(Index + 1, Nums) | Acc],
      LeftCount = count_elements(Nums, lists:seq(L, Index));
      RightCount = count_elements(Nums, lists:seq(Index + 1, R), TotalCount),
      case is_valid_split(LeftCount, RightCount) of
        true -> Index;
        false -> minimum_index_helper(Nums, L, R, TotalCount, Index + 1, NewAcc)
      end
  end.

is_valid_split(LeftCount, RightCount) ->
  (length(LeftCount) > 0 andalso lists:max(maps:values(LeftCount)) > length(LeftCount) div 2) andalso
    (length(RightCount) > 0 andalso lists:max(maps:values(RightCount)) > length(RightCount) div 2).

count_elements(Nums, Indices) ->
  count_elements(Nums, Indices, #{}).

count_elements(Nums, Indices, Acc) ->
  lists:foldl(
    fun(Index, Acc0) ->
      Element = lists:nth(Index + 1, Nums),
      case maps:is_key(Element, Acc0) of
        true -> maps:update(Element, maps:get(Element, Acc0) + 1, Acc0);
        false -> maps:put(Element, 1, Acc0)
      end
    end,
    Acc,
    Indices
  ).

count_elements(Nums, Indices, TotalCount) ->
  AllElements = count_elements(Nums, lists:seq(0,length(Nums)-1)),
  lists:foldl(
    fun(Index, Acc0) ->
      Element = lists:nth(Index + 1, Nums),
      case maps:is_key(Element, Acc0) of
        true -> maps:update(Element, Element - 1, Acc0);
        false -> maps:put(Element, 1, Acc0)
      end
    end,
    AllElements,
    Indices
  ).