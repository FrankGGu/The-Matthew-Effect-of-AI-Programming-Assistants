-module(solution).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Memo = ets:new(memo, [set, private]),
            Max = lists:max([dfs(Matrix, I, J, Memo) || I <- lists:seq(0, Rows - 1), J <- lists:seq(0, Cols - 1)]),
            ets:delete(Memo),
            Max
    end.

dfs(Matrix, I, J, Memo) ->
    case ets:lookup(Memo, {I, J}) of
        [{_, Val}] -> Val;
        [] ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Dirs = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            MaxPath = 1 + lists:max([0 | [dfs(Matrix, I + DI, J + DJ, Memo) || {DI, DJ} <- Dirs,
                                                                               I + DI >= 0, I + DI < Rows,
                                                                               J + DJ >= 0, J + DJ < Cols,
                                                                               lists:nth(I + DI + 1, Matrix) !! (J + DJ + 1) > lists:nth(I + 1, Matrix) !! (J + 1)]]),
            ets:insert(Memo, {{I, J}, MaxPath}),
            MaxPath
    end.