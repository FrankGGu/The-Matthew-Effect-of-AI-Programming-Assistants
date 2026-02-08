-module(solution).
-export([btree_coloring_game/3]).

-type treenode() :: {integer(), treenode() | null, treenode() | null}.

-spec btree_coloring_game(Root :: treenode() | null, N :: integer(), X :: integer()) -> boolean().
btree_coloring_game(Root, N, X) ->
    InitialXSubtreeSizesAcc = {not_found, 0, 0},

    {_TotalTreeSize, {found_x, LeftXSize, RightXSize}} =
        dfs_find_x_and_sizes(Root, X, InitialXSubtreeSizesAcc),

    ParentXSize = N - (LeftXSize + RightXSize + 1),

    LeftXSize > N div 2 orelse
    RightXSize > N div 2 orelse
    ParentXSize > N div 2.

dfs_find_x_and_sizes(null, _TargetX, AccXSubtreeSizes) ->
    {0, AccXSubtreeSizes};
dfs_find_x_and_sizes({Val, Left, Right}, TargetX, AccXSubtreeSizes) ->
    {LeftSize, LeftAcc} = dfs_find_x_and_sizes(Left, TargetX, AccXSubtreeSizes),
    {RightSize, RightAcc} = dfs_find_x_and_sizes(Right, TargetX, LeftAcc),

    CurrentSubtreeSize = 1 + LeftSize + RightSize,

    case RightAcc of
        {found_x, _, _} ->
            {CurrentSubtreeSize, RightAcc};
        _ ->
            case LeftAcc of
                {found_x, _, _} ->
                    {CurrentSubtreeSize, LeftAcc};
                _ ->
                    if Val == TargetX ->
                        LeftChildSubtreeSize = get_subtree_size(Left),
                        RightChildSubtreeSize = get_subtree_size(Right),
                        {CurrentSubtreeSize, {found_x, LeftChildSubtreeSize, RightChildSubtreeSize}};
                    else
                        {CurrentSubtreeSize, AccXSubtreeSizes}
                    end
            end
    end.

get_subtree_size(null) -> 0;
get_subtree_size({_Val, Left, Right}) ->
    1 + get_subtree_size(Left) + get_subtree_size(Right).