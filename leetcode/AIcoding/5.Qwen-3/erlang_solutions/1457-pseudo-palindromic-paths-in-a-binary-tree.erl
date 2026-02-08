-module(pseudopalindromic_paths).
-export([pseudo_palindromic_paths/1]).

-record(tree, {val, left, right}).

pseudo_palindromic_paths(undefined) -> 0;
pseudo_palindromic_paths(Tree) ->
    Count = 0,
    dfs(Tree, 0, Count).

dfs(undefined, _, Count) -> Count;
dfs(#tree{val=Val, left=Left, right=Right}, Path, Count) ->
    NewPath = Path bxor (1 bsl Val),
    case Left of
        undefined ->
            case Right of
                undefined ->
                    if
                        (NewPath band (NewPath - 1)) == 0 -> Count + 1;
                        true -> Count
                    end;
                _ -> dfs(Right, NewPath, Count)
            end;
        _ ->
            case Right of
                undefined -> dfs(Left, NewPath, Count);
                _ -> dfs(Left, NewPath, dfs(Right, NewPath, Count))
            end
    end.