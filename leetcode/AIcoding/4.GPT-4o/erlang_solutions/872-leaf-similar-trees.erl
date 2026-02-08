-module(solution).
-export([leafSimilar/2]).

-type tree() :: {none} | {Value, tree(), tree()}.

leafSimilar(Tree1, Tree2) ->
    leafValues(Tree1) =:= leafValues(Tree2).

leafValues({none}) -> [];
leafValues({Value, {none}, {none}}) -> [Value];
leafValues({Value, Left, Right}) ->
    leafValues(Left) ++ leafValues(Right).