-module(fruits_into_baskets_iii).
-export([totalFruit/1]).

totalFruit(Fruits) ->
  totalFruit(Fruits, 2, 0, 0, [], 0).

totalFruit([], _K, _Left, _Right, _CountMap, MaxLength) ->
  max(MaxLength, _Right - _Left);
totalFruit([Fruit | Rest], K, Left, Right, CountMap, MaxLength) ->
  NewCountMap = maps:update_with(Fruit, fun(Count) -> Count + 1 end, 1, CountMap),
  NewRight = Right + 1,
  NewMaxLength = max(MaxLength, NewRight - Left),
  case maps:size(NewCountMap) of
    Size when Size =< K ->
      totalFruit(Rest, K, Left, NewRight, NewCountMap, NewMaxLength);
    _ ->
      {FirstFruit, _} = maps:to_list(maps:from_keys(maps:keys(CountMap), 1)) -- maps:to_list(maps:from_keys(maps:keys(NewCountMap), 1)),
      totalFruit(Rest, K, Left + 1, NewRight, slide_window(Fruits, Left, Right, Fruit), NewMaxLength)
  end.

slide_window(Fruits, Left, Right, FruitToRemove) ->
  slide_window(Fruits, Left, Right, FruitToRemove, maps:new()).

slide_window(Fruits, Left, Right, FruitToRemove, CountMap) ->
  case lists:nth(Left + 1, Fruits) of
    FruitToRemove ->
      NewCountMap = maps:remove(FruitToRemove, CountMap),
      CountMapAfterRemove = maps:without([FruitToRemove], CountMap),
      CountMapAfterRemove;
    Fruit ->
      Count = maps:get(Fruit, CountMap, 0),
      NewCountMap = maps:put(Fruit, Count + 1, CountMap),
      NewCountMap
  end.

slide_window(Fruits, Left, Right, FruitToRemove, CountMap) when Left + 1 >= Right ->
  CountMap.

slide_window(Fruits, Left, Right, FruitToRemove, CountMap) ->
  case lists:nth(Left + 1, Fruits) of
    FruitToRemove ->
      NewCountMap = maps:remove(FruitToRemove, CountMap),
      CountMapAfterRemove = maps:without([FruitToRemove], CountMap),
      CountMapAfterRemove;
    Fruit ->
      Count = maps:get(Fruit, CountMap, 0),
      NewCountMap = maps:put(Fruit, Count + 1, CountMap),
      NewCountMap
  end,
  slide_window(Fruits, Left + 1, Right, FruitToRemove, CountMap).

slide_window(Fruits, Left, Right, FruitToRemove) ->
  lists:foldl(
    fun(Fruit, AccMap) ->
      case maps:is_key(Fruit, AccMap) of
        true ->
          maps:update_with(Fruit, fun(Count) -> Count + 1 end, 1, AccMap);
        false ->
          maps:put(Fruit, 1, AccMap)
      end
    end,
    maps:new(),
    sublist(Fruits, Left, Right - Left)
  ).
sublist(List, Start, Length) ->
  sublist(List, Start, Length, []).

sublist(_, _, 0, Acc) ->
  lists:reverse(Acc);
sublist([H | T], Start, Length, Acc) when Start =< 0 ->
  sublist(T, Start - 1, Length -1, [H | Acc]);
sublist([_ | T], Start, Length, Acc) ->
  sublist(T, Start - 1, Length, Acc).