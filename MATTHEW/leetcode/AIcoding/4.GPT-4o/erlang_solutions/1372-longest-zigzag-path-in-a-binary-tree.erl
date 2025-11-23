-module(solution).
-export([longest_zigzag/1]).

-record(tree, {val, left, right}).

longest_zigzag(Root) ->
    {MaxLength, _} = longest_zigzag_helper(Root, 0, 0, 0),
    MaxLength.

longest_zigzag_helper(null, L, R, Max) ->
    {Max, Max};
longest_zigzag_helper(#tree{left=Left, right=Right}, L, R, Max) ->
    Max1 = max(Max, L),
    {Max1L, Max1R} = longest_zigzag_helper(Left, R + 1, 0, Max1),
    {Max2L, Max2R} = longest_zigzag_helper(Right, 0, L + 1, Max1L),
    {Max2L, Max2R}.