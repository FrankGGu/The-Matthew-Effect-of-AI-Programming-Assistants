-module(solution).
-export([findMatrix/1]).

findMatrix(Numbers) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Numbers),
    Rows = lists:seq(1, lists:max(maps:values(Count))),
    lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(N, Acc2) -> 
            case lists:keymember(N, 1, Acc2) of
                true -> 
                    [lists:keystore(N, 1, Acc2, {N, maps:get(N, Count) - 1}) | Acc2];
                false -> 
                    [{N, maps:get(N, Count) - 1} | Acc2]
            end
        end, [], Rows)
    end, [], Rows).

extract_values(List) ->
    lists:map(fun({N, _}) -> N end, List).