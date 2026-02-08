-module(merge_similar_items).
-export([merge_similar_items/2]).

merge_similar_items(Items1, Items2) ->
  Merged = merge_items(Items1, Items2),
  lists:sort(fun([Value1, _], [Value2, _]) -> Value1 < Value2 end, Merged).

merge_items(Items1, Items2) ->
  Map1 = lists:foldl(fun([Value, Weight], Acc) -> maps:put(Value, Weight, Acc) end, #{}, Items1),
  lists:foldl(
    fun([Value, Weight], Acc) ->
      case maps:get(Value, Acc, undefined) of
        undefined ->
          maps:put(Value, Weight, Acc);
        ExistingWeight ->
          maps:put(Value, ExistingWeight + Weight, Acc)
      end
    end,
    Map1,
    Items2
  )
  |> maps:to_list()
  |> lists:map(fun({Value, Weight}) -> [Value, Weight] end).