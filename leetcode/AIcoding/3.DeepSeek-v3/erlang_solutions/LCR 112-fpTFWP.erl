-module(solution).
-export([longest_increasing_path/1]).

longest_increasing_path(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            M = length(Matrix),
            N = length(hd(Matrix)),
            Memo = lists:duplicate(M, lists:duplicate(N, 0)),
            Max = lists:max([dfs(Matrix, I, J, Memo) || I <- lists:seq(0, M-1), J <- lists:seq(0, N-1)]),
            Max
    end.

dfs(Matrix, I, J, Memo) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    case lists:nth(I+1, lists:nth(J+1, Memo)) of
        0 ->
            Directions = [{0,1}, {1,0}, {0,-1}, {-1,0}],
            Current = lists:nth(I+1, lists:nth(J+1, Matrix)),
            MaxPath = 1 + lists:max([0 | [dfs(Matrix, I+DI, J+DJ, Memo) || {DI, DJ} <- Directions,
                                                                             I+DI >= 0, I+DI < M,
                                                                             J+DJ >= 0, J+DJ < N,
                                                                             lists:nth(I+DI+1, lists:nth(J+DJ+1, Matrix)) > Current]]),
            NewMemo = update_memo(Memo, I, J, MaxPath),
            MaxPath;
        Val -> Val
    end.

update_memo(Memo, I, J, Val) ->
    Row = lists:nth(I+1, Memo),
    NewRow = lists:sublist(Row, J) ++ [Val] ++ lists:nthtail(J+1, Row),
    lists:sublist(Memo, I) ++ [NewRow] ++ lists:nthtail(I+1, Memo).