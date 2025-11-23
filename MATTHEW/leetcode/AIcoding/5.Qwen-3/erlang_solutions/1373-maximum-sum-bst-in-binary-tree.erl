-module(max_sum_bst_in_binary_tree).
-export([max_sum_bst/1]).

-type node() :: {integer(), node() | nil, node() | nil}.

-spec max_sum_bst(node()) -> integer().
max_sum_bst(Tree) ->
    {_, MaxSum, _} = dfs(Tree),
    MaxSum.

dfs(nil) ->
    {0, 0, true};
dfs({Val, Left, Right}) ->
    {LeftSum, LeftMax, LeftBST} = dfs(Left),
    {RightSum, RightMax, RightBST} = dfs(Right),
    if
        LeftBST andalso RightBST ->
            case (Left /= nil andalso Val > element(1, Left)) orelse Left == nil of
                true ->
                    case (Right /= nil andalso Val < element(1, Right)) orelse Right == nil of
                        true ->
                            CurrentSum = Val + LeftSum + RightSum,
                            CurrentMax = max(LeftMax, RightMax, CurrentSum),
                            {CurrentSum, CurrentMax, true};
                        false ->
                            {0, max(LeftMax, RightMax), false}
                    end;
                false ->
                    {0, max(LeftMax, RightMax), false}
            end;
        true ->
            {0, max(LeftMax, RightMax), false}
    end.