-module(count_items_matching_rule).
-export([count_matches/3]).

count_matches(Items, RuleKey, RuleValue) ->
  lists:foldl(
    fun(Item, Acc) ->
      case matches(Item, RuleKey, RuleValue) of
        true -> Acc + 1;
        false -> Acc
      end
    end,
    0,
    Items
  ).

matches([Type, Color, Name], "type", RuleValue) -> Type =:= RuleValue;
matches([Type, Color, Name], "color", RuleValue) -> Color =:= RuleValue;
matches([Type, Color, Name], "name", RuleValue) -> Name =:= RuleValue.