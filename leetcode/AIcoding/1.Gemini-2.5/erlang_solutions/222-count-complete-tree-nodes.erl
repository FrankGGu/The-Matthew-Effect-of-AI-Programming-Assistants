-module(solution).
-export([countNodes/1]).

height(nil) -> 0;
height({node, _, Left, _}) -> 1 + height(Left).

countNodes(nil) -> 0;
countNodes({node, _, Left, Right}) ->
    H = height({node, 0, Left, Right}),
    HR = height(Right),
    if
        HR == H - 1 ->
            (1 bsl (H - 1)) + countNodes(Right);
        true ->
            (1 bsl (H - 2)) + countNodes(Left)
    end.