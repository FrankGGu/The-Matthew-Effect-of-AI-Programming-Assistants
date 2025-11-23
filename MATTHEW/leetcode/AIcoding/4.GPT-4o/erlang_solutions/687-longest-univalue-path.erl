-module(solution).
-export([longest_univalue_path/1]).

-record(node, {val, left = none, right = none}).

longest_univalue_path(Tree) ->
    {_, MaxLength} = longest_univalue_path_helper(Tree),
    MaxLength.

longest_univalue_path_helper(none) ->
    {0, 0};
longest_univalue_path_helper(#node{val=Val, left=Left, right=Right}) ->
    {LeftLength, LeftMax} = longest_univalue_path_helper(Left),
    {RightLength, RightMax} = longest_univalue_path_helper(Right),
    NewLength = case {Left, Right} of
        {none, none} -> 0;
        {none, #node{val=Val}} -> RightLength + 1;
        {#node{val=Val}, none} -> LeftLength + 1;
        {#node{val=Val}, #node{val=Val}} -> LeftLength + RightLength + 2
    end,
    MaxLength = max(NewLength, max(LeftMax, RightMax)),
    {NewLength, MaxLength}.