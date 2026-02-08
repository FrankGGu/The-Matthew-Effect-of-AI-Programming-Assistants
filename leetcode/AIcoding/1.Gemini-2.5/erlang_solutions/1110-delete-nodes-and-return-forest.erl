-module(solution).
-export([del_nodes/2]).

-record('TreeNode', {val=0, left=nil, right=nil}).

-spec del_nodes(Root :: 'TreeNode' | nil, ToDelete :: [integer()]) -> ['TreeNode'].
del_nodes(Root, ToDelete) ->
    ToDeleteSet = gb_sets:from_list(ToDelete),
    {_, Forest} = dfs(Root, true, ToDeleteSet),
    Forest.

dfs(nil, _IsParentDeleted, _ToDeleteSet) ->
    {nil, []};
dfs(Node = #'TreeNode'{val=Val, left=Left, right=Right}, IsParentDeleted, ToDeleteSet) ->
    IsDeleted = gb_sets:is_member(Val, ToDeleteSet),

    {ModifiedLeft, RootsFromLeft} = dfs(Left, IsDeleted, ToDeleteSet),
    {ModifiedRight, RootsFromRight} = dfs(Right, IsDeleted, ToDeleteSet),

    NewNode = Node#'TreeNode'{left=ModifiedLeft, right=ModifiedRight},

    CurrentRoots = RootsFromLeft ++ RootsFromRight,

    if
        IsDeleted ->
            {nil, CurrentRoots};
        true -> %% not IsDeleted
            if
                IsParentDeleted ->
                    {NewNode, [NewNode | CurrentRoots]};
                true -> %% not IsParentDeleted
                    {NewNode, CurrentRoots}
            end
    end.