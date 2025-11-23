-module(out_of_boundary_paths).
-export([find_paths/3]).

find_paths(Height, Width, Steps) ->
    Memo = ets:new(memo, [set, public, {keypos, 1}]),
    Result = dfs(0, 0, Steps, Height, Width, Memo),
    ets:delete(Memo),
    Result.

dfs(X, Y, 0, _, _, _) ->
    1;
dfs(X, Y, Steps, Height, Width, Memo) ->
    Key = {X, Y, Steps},
    case ets:lookup(Memo, Key) of
        [Val] -> Val;
        [] ->
            Total = lists:sum([
                if X == 0 -> dfs(X + 1, Y, Steps - 1, Height, Width, Memo);
                   true -> 0
                end,
                if X == Height - 1 -> dfs(X - 1, Y, Steps - 1, Height, Width, Memo);
                   true -> 0
                end,
                if Y == 0 -> dfs(X, Y + 1, Steps - 1, Height, Width, Memo);
                   true -> 0
                end,
                if Y == Width - 1 -> dfs(X, Y - 1, Steps - 1, Height, Width, Memo);
                   true -> 0
                end
            ]),
            ets:insert(Memo, {Key, Total}),
            Total
    end.