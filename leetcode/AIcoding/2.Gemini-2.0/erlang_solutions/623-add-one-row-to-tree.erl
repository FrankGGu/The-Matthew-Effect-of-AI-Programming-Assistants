-module(solution).
-export([add_one_row/3]).

add_one_row(Root, V, D) ->
    add_one_row(Root, V, D, 1).

add_one_row(Root, V, D, CurrentDepth) when Root =:= null ->
    null;
add_one_row(Root, V, D, CurrentDepth) when D =:= 1 ->
    {V, Root, null};
add_one_row(Root, V, D, CurrentDepth) when CurrentDepth =:= D - 1 ->
    {element(1, Root), {V, element(2, Root), null}, {V, null, element(3, Root)}};
add_one_row(Root, V, D, CurrentDepth) ->
    {element(1, Root), add_one_row(element(2, Root), V, D, CurrentDepth + 1), add_one_row(element(3, Root), V, D, CurrentDepth + 1)}.