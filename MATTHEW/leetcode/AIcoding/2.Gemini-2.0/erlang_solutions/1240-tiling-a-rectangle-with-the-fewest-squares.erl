-module(tiling_rectangle).
-export([tilingRectangle/2]).

tilingRectangle(N, M) ->
    memo(N, M, #{}).

memo(N, M, Memo) ->
    case maps:get({N, M}, Memo, undefined) of
        undefined ->
            Result = solve(N, M, Memo);
            maps:put({N, M}, Result, Memo);
            Result;
        Result ->
            Result
    end.

solve(N, M, Memo) ->
    if N =:= M ->
        1;
    if N > M ->
        solve(M, N, Memo);
    true ->
        case N of
            1 ->
                M;
            _ ->
                Min = lists:foldl(fun(K, Acc) ->
                                          min(Acc, 1 + memo(N-K, M, Memo) + memo(K, M-(N-K), Memo))
                                  end, infinity, lists:seq(1, N-1)),
                Min2 = lists:foldl(fun(K, Acc) ->
                                           min(Acc, 1 + memo(N, M-K, Memo) + memo(N- (M-K), K, Memo))
                                   end, infinity, lists:seq(1, M-1)),
                min(Min, Min2)
        end
    end.