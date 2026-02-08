-module(solution).
-export([find_target/2]).

-record(node, {val, left = none, right = none}).

find_target(Root, Target) ->
    Values = [],
    collect_values(Root, Values),
    find_two_sum(Values, Target).

collect_values(none, Values) ->
    Values;
collect_values(Node, Values) ->
    collect_values(Node#node.left, Values1),
    collect_values(Node#node.right, [Node#node.val | Values1]).

find_two_sum(Values, Target) ->
    SortedValues = lists:sort(Values),
    find_pair(SortedValues, Target).

find_pair([], _) ->
    false;
find_pair([_], _) ->
    false;
find_pair([H | T], Target) ->
    case lists:member(Target - H, T) of
        true -> true;
        false -> find_pair(T, Target)
    end.