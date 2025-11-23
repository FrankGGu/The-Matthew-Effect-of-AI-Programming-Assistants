-module(solution).
-export([right_side_view/1]).

-spec right_side_view(TreeNode :: term()) -> [integer()].
right_side_view(Root) ->
    ResultMap = dfs(Root, 0, #{}),
    SortedPairs = lists:sort(fun({K1, _}, {K2, _}) -> K1 =< K2 end, maps:to_list(ResultMap)),
    lists:map(fun({_, V}) -> V end, SortedPairs).

dfs(null, _, Acc) ->
    Acc;
dfs({Val, Left, Right}, Depth, Acc) ->
    NewAcc1 = case maps:is_key(Depth, Acc) of
                  true -> Acc;
                  false -> maps:put(Depth, Val, Acc)
              end,
    NewAcc2 = dfs(Right, Depth + 1, NewAcc1),
    dfs(Left, Depth + 1, NewAcc2).