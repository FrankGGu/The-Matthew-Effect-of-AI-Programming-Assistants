-module(solution).
-export([rightSideView/1]).

-type tree() :: none | {Value, tree(), tree()}.

rightSideView(Root) ->
    rightSideView(Root, 1, []).

rightSideView(none, _, Acc) ->
    lists:reverse(Acc);
rightSideView({Value, Left, Right}, Level, Acc) ->
    case lists:member(Level, Acc) of
        true -> rightSideView(Left, Level + 1, Acc);
        false -> rightSideView(Left, Level + 1, [Value | Acc])
    end,
    rightSideView(Right, Level + 1, Acc).