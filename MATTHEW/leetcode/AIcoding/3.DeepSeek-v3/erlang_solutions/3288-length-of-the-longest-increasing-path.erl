-spec longest_increasing_path(Matrix :: [[integer()]]) -> integer().
longest_increasing_path(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            M = length(Matrix),
            N = length(hd(Matrix)),
            Memo = maps:new(),
            lists:max([dfs(Matrix, I, J, Memo) || I <- lists:seq(0, M-1), J <- lists:seq(0, N-1)])
    end.

dfs(Matrix, I, J, Memo) ->
    case maps:get({I, J}, Memo, undefined) of
        undefined ->
            M = length(Matrix),
            N = length(hd(Matrix)),
            Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
            Max = 1 + lists:max([0 | [dfs(Matrix, I+Di, J+Dj, Memo) || {Di, Dj} <- Directions,
                                                                     I+Di >= 0, I+Di < M,
                                                                     J+Dj >= 0, J+Dj < N,
                                                                     lists:nth(J+Dj+1, lists:nth(I+Di+1, Matrix)) > lists:nth(J+1, lists:nth(I+1, Matrix))]]),
            maps:put({I, J}, Max, Memo),
            Max;
        Cached -> Cached
    end.