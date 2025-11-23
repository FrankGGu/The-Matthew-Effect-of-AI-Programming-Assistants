-module(maximum_elegance).
-export([max_elegance/2]).

max_elegance(Items, K) ->
  SortedItems = lists:sort(fun({P1,_}, {P2,_}) -> P1 > P2 end, Items),
  {Elegance, Remainder} = lists:foldl(fun({Profit, Category}, {Acc, Rem}) ->
    if lists:len(Rem) < K then
      {Acc + Profit, Rem ++ [{Profit, Category}]}
    else
      {Acc, Rem}
    end
  end, {0, []}, SortedItems),

  CategoriesCount = lists:foldl(fun({_, Cat}, Acc) ->
    maps:update_with(Cat, fun(Count) -> Count + 1 end, 1, Acc)
  end, #{}, Remainder),

  ExtraElegance =
    case lists:len(Remainder) < K of
      true -> 0;
      false ->
        RemainCategories = maps:keys(CategoriesCount),
        SpareItems = lists:droplast(K, SortedItems),
        SpareItemsWithNewCategory = lists:filter(fun({_, Cat}) -> not lists:member(Cat, RemainCategories) end, SpareItems),
        case SpareItemsWithNewCategory of
          [] -> 0;
          _ ->
            DroppedItem = lists:min(lists:map(fun({Profit, _}) -> Profit end, Remainder)),
            NewItem = lists:max(lists:map(fun({Profit, _}) -> Profit end, SpareItemsWithNewCategory)),
            max(0, NewItem - DroppedItem)
        end
    end,

  Elegance + ExtraElegance * ExtraElegance.