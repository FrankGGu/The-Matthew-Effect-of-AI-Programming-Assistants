-module(solution).
-export([color_tree/1]).

-type tree() :: {nil} | {Value, tree(), tree()}.

color_tree(nil) -> [];
color_tree({Value, Left, Right}) ->
    [{Value, color(Left, Right)} | color_tree(Left) ++ color_tree(Right)].

color(Left, Right) ->
    case {Left, Right} of
        {nil, nil} -> "black";
        {nil, _} -> "red";
        {_, nil} -> "red";
        {_, _} -> "black"
    end.