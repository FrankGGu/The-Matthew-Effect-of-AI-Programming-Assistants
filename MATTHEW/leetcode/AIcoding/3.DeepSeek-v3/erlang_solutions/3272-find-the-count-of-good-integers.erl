-module(solution).
-export([count_good_integers/3]).

count_good_integers(Start, End, K) ->
    count_good(End, K) - count_good(Start - 1, K).

count_good(N, K) ->
    S = integer_to_list(N),
    Len = length(S),
    DP = maps:new(),
    {Res, _} = dfs(0, true, 0, S, K, Len, DP),
    Res.

dfs(Pos, IsTight, Sum, S, K, Len, DP) ->
    Key = {Pos, IsTight, Sum},
    case maps:get(Key, DP, undefined) of
        undefined ->
            Res = if
                Pos =:= Len ->
                    if Sum rem K =:= 0 -> 1; true -> 0 end;
                true ->
                    Limit = case IsTight of
                        true -> lists:nth(Pos + 1, S) - $0;
                        false -> 9
                    end,
                    lists:foldl(fun(D, Acc) ->
                        NewIsTight = IsTight and (D =:= Limit),
                        NewSum = Sum + D,
                        {Cnt, NewDP} = dfs(Pos + 1, NewIsTight, NewSum, S, K, Len, DP),
                        {Acc + Cnt, NewDP}
                    end, {0, DP}, lists:seq(0, Limit))
            end,
            {Res, maps:put(Key, Res, DP)};
        Cached ->
            {Cached, DP}
    end.