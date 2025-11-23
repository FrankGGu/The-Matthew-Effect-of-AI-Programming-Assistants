-spec max_jumps(Arr :: [integer()], D :: integer()) -> integer().
max_jumps(Arr, D) ->
    N = length(Arr),
    Mem = maps:new(),
    lists:max([dfs(Arr, D, I, Mem) || I <- lists:seq(0, N - 1)]).

dfs(Arr, D, I, Mem) ->
    case maps:get(I, Mem, undefined) of
        undefined ->
            N = length(Arr),
            Max = 1,
            Left = lists:max([0, I - D]),
            Right = lists:min([N - 1, I + D]),
            Jumps = lists:foldl(fun(J, Acc) ->
                if
                    J =/= I andalso lists:nth(J + 1, Arr) < lists:nth(I + 1, Arr) ->
                        [dfs(Arr, D, J, Mem) | Acc];
                    true ->
                        Acc
                end
            end, [], lists:seq(Left, Right)),
            Res = case Jumps of
                [] -> 1;
                _ -> 1 + lists:max(Jumps)
            end,
            maps:put(I, Res, Mem),
            Res;
        Val ->
            Val
    end.