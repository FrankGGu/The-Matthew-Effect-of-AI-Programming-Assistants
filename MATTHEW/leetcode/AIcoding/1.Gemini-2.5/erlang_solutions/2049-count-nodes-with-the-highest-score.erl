-module(solution).
-export([count_nodes_with_highest_score/1]).

count_nodes_with_highest_score(Parents) ->
    N = length(Parents),
    Children = build_children_adj(N, Parents),
    InitialSubtreeSizes = array:new([{size, N}, {default, 0}]),
    {_, FinalSubtreeSizes} = subtree_size_dfs(0, Children, InitialSubtreeSizes),
    {_MaxScore, CountMaxScore} = calculate_scores_and_max(N, Children, FinalSubtreeSizes),
    CountMaxScore.

build_children_adj(N, Parents) ->
    InitialChildren = array:new([{size, N}, {default, []}]),
    lists:foldl(
        fun({Node, Parent}, AccChildren) ->
            if Parent == -1 -> AccChildren;
               true ->
                   ChildrenOfParent = array:get(Parent, AccChildren),
                   array:set(Parent, [Node | ChildrenOfParent], AccChildren)
            end
        end,
        InitialChildren,
        lists:zip(lists:seq(0, N - 1), Parents)
    ).

subtree_size_dfs(Node, Children, SubtreeSizesAcc) ->
    NodeChildren = array:get(Node, Children),
    {CurrentSubtreeSize, UpdatedSubtreeSizesAcc1} =
        lists:foldl(
            fun(Child, {AccSize, AccSubtreeSizes}) ->
                {ChildSize, UpdatedSubtreeSizes} = subtree_size_dfs(Child, Children, AccSubtreeSizes),
                {AccSize + ChildSize, UpdatedSubtreeSizes}
            end,
            {1, SubtreeSizesAcc},
            NodeChildren
        ),
    UpdatedSubtreeSizes2 = array:set(Node, CurrentSubtreeSize, UpdatedSubtreeSizesAcc1),
    {CurrentSubtreeSize, UpdatedSubtreeSizes2}.

calculate_scores_and_max(N, Children, SubtreeSizes) ->
    lists:foldl(
        fun(Node, {MaxScore, CountMaxScore}) ->
            NodeChildren = array:get(Node, Children),
            CurrentScore = 1,
            ParentSideSize = N - array:get(Node, SubtreeSizes),
            ScoreAfterParent = if ParentSideSize > 0 -> CurrentScore * ParentSideSize;
                               true -> CurrentScore
                               end,
            FinalNodeScore = lists:foldl(
                fun(Child, AccScore) ->
                    ChildSubtreeSize = array:get(Child, SubtreeSizes),
                    if ChildSubtreeSize > 0 -> AccScore * ChildSubtreeSize;
                       true -> AccScore
                    end
                end,
                ScoreAfterParent,
                NodeChildren
            ),
            if FinalNodeScore > MaxScore ->
                {FinalNodeScore, 1};
            FinalNodeScore == MaxScore ->
                {MaxScore, CountMaxScore + 1};
            true ->
                {MaxScore, CountMaxScore}
            end
        end,
        {0, 0},
        lists:seq(0, N - 1)
    ).