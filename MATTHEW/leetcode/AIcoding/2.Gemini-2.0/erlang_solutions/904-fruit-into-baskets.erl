-module(fruit_into_baskets).
-export([totalFruit/1]).

totalFruit(Fruits) ->
  totalFruit(Fruits, 0, 0, [], 0).

totalFruit([], Start, Max, _, Max) ->
  Max;
totalFruit([Fruit | Rest], Start, Max, Basket, Current) ->
  case lists:member(Fruit, Basket) of
    true ->
      totalFruit(Rest, Start, Max, Basket, Current + 1);
    false ->
      case length(Basket) < 2 of
        true ->
          totalFruit(Rest, Start, Max, [Fruit | Basket], Current + 1);
        false ->
          Max1 = max(Max, Current);
          NewStart = findNewStart(lists:sublist(Fruits, Start, length(Fruits)), lists:nth(1, Basket));
          totalFruit(Rest, NewStart, Max1, [Fruit, lists:nth(2, Basket)], length(lists:sublist(Fruits, NewStart, length(Fruits))))
      end
  end.

findNewStart(Fruits, Fruit) ->
  findNewStart(Fruits, Fruit, 1).

findNewStart([Fruit | _], Fruit, Index) ->
  Index;
findNewStart([_ | Rest], Fruit, Index) ->
  findNewStart(Rest, Fruit, Index + 1).