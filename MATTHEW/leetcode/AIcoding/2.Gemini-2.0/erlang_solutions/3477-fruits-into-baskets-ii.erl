-module(fruits_into_baskets_ii).
-export([totalFruit/1]).

totalFruit(Fruits) ->
  totalFruit(Fruits, 2).

totalFruit(Fruits, K) ->
  totalFruit(Fruits, K, 0, 0, [], 0).

totalFruit([], _K, _Start, MaxLen, _Baskets, Max) ->
  max(Max, MaxLen);
totalFruit([Fruit | Rest], K, Start, Len, Baskets, Max) ->
  case lists:keyfind(Fruit, 1, Baskets) of
    false ->
      case length(Baskets) < K of
        true ->
          totalFruit(Rest, K, Start, Len + 1, [{Fruit, Len + 1} | Baskets], max(Max, Len + 1));
        false ->
          {_, MinIndex} = lists:min([ {V, I} || {_, V} <- Baskets, I <- lists:seq(1,length(Baskets))]),
          FruitToRemove = element(1, lists:nth(MinIndex, Baskets)),
          NewBaskets = lists:delete(element(MinIndex, Baskets), Baskets),
          NewStart = lists:foldl(fun({F, Index}, Acc) ->
                                     case F =:= FruitToRemove of
                                       true -> Index;
                                       false -> Acc
                                     end
                                 end, 0, lists:zip(Fruits, lists:seq(1, length(Fruits)))),
          totalFruit(Rest, K, NewStart, Len + 1, [{Fruit, Len + 1} | NewBaskets], max(Max, Len) )
      end;
    _ ->
      NewBaskets = lists:keyreplace(Fruit, 1, Baskets, {Fruit, Len + 1}),
      totalFruit(Rest, K, Start, Len + 1, NewBaskets, max(Max, Len + 1))
  end.