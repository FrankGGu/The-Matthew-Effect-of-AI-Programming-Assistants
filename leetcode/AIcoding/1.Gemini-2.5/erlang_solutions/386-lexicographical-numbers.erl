-module(solution).
-export([lexical_order/1]).

lexical_order(N) ->
    lists:reverse(lexical_dfs(1, N, [])).

lexical_dfs(Current, N, Acc) ->
    if
        Current > N ->
            Acc;
        true ->
            Acc1 = [Current | Acc],
            Acc2 = lexical_dfs(Current * 10, N, Acc1),
            if
                (Current rem 10 =:= 9) or (Current + 1 > N) ->
                    Acc2;
                true ->
                    lexical_dfs(Current + 1, N, Acc2)
            end
    end.