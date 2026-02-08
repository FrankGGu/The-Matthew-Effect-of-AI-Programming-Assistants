-module(leaf_similar_trees).
-export([leaf_similar/2]).

-include_lib("eunit/include/eunit.hrl").

leaf_similar(Tree1, Tree2) ->
    Leaves1 = collect_leaves(Tree1),
    Leaves2 = collect_leaves(Tree2),
    Leaves1 == Leaves2.

collect_leaves(nil) ->
    [];
collect_leaves({Val, Left, Right}) ->
    case {Left, Right} of
        {nil, nil} ->
            [Val];
        _ ->
            collect_leaves(Left) ++ collect_leaves(Right)
    end.