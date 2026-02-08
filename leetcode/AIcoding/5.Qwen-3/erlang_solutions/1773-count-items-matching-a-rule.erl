-module(solution).
-export([count_matches/2]).

count_matches(Rules, Items) ->
    count_matches(Rules, Items, 0).

count_matches(_, [], Acc) ->
    Acc;
count_matches(Rules, [Item | Rest], Acc) ->
    case check_rule(Item, Rules) of
        true -> count_matches(Rules, Rest, Acc + 1);
        false -> count_matches(Rules, Rest, Acc)
    end.

check_rule(Item, [Rule | _]) ->
    [Type, Value] = Rule,
    case Type of
        "type" -> Item ++ [] == [Value];
        "color" -> Item ++ [] == [Value];
        "name" -> Item ++ [] == [Value]
    end;
check_rule(Item, []) ->
    false.