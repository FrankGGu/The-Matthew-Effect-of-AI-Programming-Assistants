-module(solution).
-export([count_special_numbers/1]).

count_special_numbers(N) ->
    S = integer_to_list(N),
    Len = length(S),
    DP = maps:new(),
    {Ans, _} = dfs(S, 0, 0, Len, DP, true, false),
    Ans.

dfs(S, Pos, Mask, Len, DP, IsTight, IsNum) ->
    Key = {Pos, Mask, IsTight, IsNum},
    case maps:is_key(Key, DP) of
        true -> {maps:get(Key, DP), DP};
        false ->
            if
                Pos =:= Len ->
                    if
                        IsNum -> {1, DP};
                        true -> {0, DP}
                    end;
                true ->
                    Limit = case IsTight of
                        true -> lists:nth(Pos + 1, S) - $0;
                        false -> 9
                    end,
                    {Res, DP1} = case IsNum of
                        false ->
                            dfs(S, Pos + 1, Mask, Len, DP, false, false);
                        true -> {0, DP}
                    end,
                    {Sum, DP2} = lists:foldl(fun(D, {Acc, DPAcc}) ->
                        if
                            (Mask band (1 bsl D)) =/= 0 -> {Acc, DPAcc};
                            true ->
                                {Cnt, DPNew} = dfs(S, Pos + 1, Mask bor (1 bsl D), Len, DPAcc, IsTight and (D =:= Limit), true),
                                {Acc + Cnt, DPNew}
                        end
                    end, {Res, DP1}, lists:seq(0, Limit)),
                    DP3 = maps:put(Key, Sum, DP2),
                    {Sum, DP3}
            end
    end.