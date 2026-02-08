-module(solution).
-export([all_possible_fb_trees/1]).

all_possible_fb_trees(N) when N rem 2 == 0 -> [];
all_possible_fb_trees(N) -> all_possible_fb_trees_helper(N).

all_possible_fb_trees_helper(1) ->
    [#{value => nil, left => [], right => []}];
all_possible_fb_trees_helper(N) ->
    [Tree || 
        LeftCount <- lists:seq(1, N - 2, 2),
        RightCount = N - 1 - LeftCount,
        LeftTrees = all_possible_fb_trees_helper(LeftCount),
        RightTrees = all_possible_fb_trees_helper(RightCount),
        Left <- LeftTrees,
        Right <- RightTrees,
        Tree = #{value => nil, left => [Left], right => [Right]}
    ].