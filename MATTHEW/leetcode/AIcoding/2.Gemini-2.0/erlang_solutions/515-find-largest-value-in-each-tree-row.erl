-module(largest_values_in_tree_rows).
-export([largest_values/1]).

-spec largest_values(Tree :: tree()) -> [integer()].
largest_values(Tree) ->
    levels(Tree, 0, []).

levels(null, _Level, Acc) ->
    Acc;
levels({Value, Left, Right}, Level, Acc) ->
    NewAcc =
        case lists:nth(Level + 1, lists:concat([Acc, [[]]])) of
            [] ->
                lists:nthtail(Level, lists:concat([Acc, [[Value]]]));
            Max ->
                lists:nthtail(Level, lists:concat([lists:sublist(Acc,1,Level), [[max(Value, Max)]]]))
        end,
    levels(Left, Level + 1, NewAcc),
    levels(Right, Level + 1, NewAcc).

-type tree() :: null | {integer(), tree(), tree()}.