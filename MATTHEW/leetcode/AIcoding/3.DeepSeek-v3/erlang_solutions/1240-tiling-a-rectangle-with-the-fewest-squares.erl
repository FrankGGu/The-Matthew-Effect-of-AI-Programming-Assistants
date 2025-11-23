-module(solution).
-export([tiling_rectangle/2]).

tiling_rectangle(N, M) ->
    Mem = maps:new(),
    {Ans, _} = dp(N, M, Mem),
    Ans.

dp(N, M, Mem) ->
    case maps:find({N, M}, Mem) of
        {ok, Val} -> {Val, Mem};
        error ->
            if
                N == M -> {1, maps:put({N, M}, 1, Mem)};
                true ->
                    Min1 = lists:min([N, M]),
                    Res1 = 1 bsl 30,
                    {Res2, Mem1} = case Min1 of
                        N -> split_vertical(N, M, Mem);
                        M -> split_horizontal(N, M, Mem)
                    end,
                    Res = min(Res1, Res2),
                    {Res, maps:put({N, M}, Res, Mem1)}
            end
    end.

split_vertical(N, M, Mem) ->
    split_vertical(N, M, 1, 1 bsl 30, Mem).

split_vertical(N, M, K, Min, Mem) when K =< N div 2 ->
    {Res1, Mem1} = dp(K, M, Mem),
    {Res2, Mem2} = dp(N - K, M, Mem1),
    NewMin = min(Min, Res1 + Res2),
    split_vertical(N, M, K + 1, NewMin, Mem2);
split_vertical(_, _, _, Min, Mem) ->
    {Min, Mem}.

split_horizontal(N, M, Mem) ->
    split_horizontal(N, M, 1, 1 bsl 30, Mem).

split_horizontal(N, M, K, Min, Mem) when K =< M div 2 ->
    {Res1, Mem1} = dp(N, K, Mem),
    {Res2, Mem2} = dp(N, M - K, Mem1),
    NewMin = min(Min, Res1 + Res2),
    split_horizontal(N, M, K + 1, NewMin, Mem2);
split_horizontal(_, _, _, Min, Mem) ->
    {Min, Mem}.