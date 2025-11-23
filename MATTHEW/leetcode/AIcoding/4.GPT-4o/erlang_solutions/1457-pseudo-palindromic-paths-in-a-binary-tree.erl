-module(solution).
-export([pseudo_palindromic_paths/1]).

-record(tree, {val, left = null, right = null}).

pseudo_palindromic_paths(Root) ->
    Count = pseudo_palindromic_paths_helper(Root, 0),
    Count.

pseudo_palindromic_paths_helper(null, _) -> 
    0;
pseudo_palindromic_paths_helper(Tree, Path) ->
    NewPath = Path bxor (1 bsl (Tree#tree.val)),
    case {Tree#tree.left, Tree#tree.right} of
        {null, null} -> 
            if 
                (NewPath band (NewPath - 1)) == 0 -> 1;
                true -> 0
            end;
        {Left, Right} -> 
            pseudo_palindromic_paths_helper(Left, NewPath) + 
            pseudo_palindromic_paths_helper(Right, NewPath)
    end.