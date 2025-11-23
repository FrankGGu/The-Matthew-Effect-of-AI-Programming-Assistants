-module(solution).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    {LISLen, _TailsTree} = lists:foldl(
        fun(Num, {CurrentLISLen, TailsTree}) ->
            case gb_trees:lookup_ge(Num, TailsTree) of
                {value, OldTail, _} ->
                    NewTailsTree = gb_trees:delete(OldTail, TailsTree),
                    NewTailsTree2 = gb_trees:insert(Num, true, NewTailsTree),
                    {CurrentLISLen, NewTailsTree2}
                none ->
                    NewTailsTree = gb_trees:insert(Num, true, TailsTree),
                    {CurrentLISLen + 1, NewTailsTree}
            end
        end,
        {0, gb_trees:empty()},
        Nums
    ),
    N - LISLen.