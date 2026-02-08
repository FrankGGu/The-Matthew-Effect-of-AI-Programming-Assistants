-module(longest_harmonious_subsequence).
-export([main/1]).

main(Numbers) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Numbers),
    lists:foldl(fun(K, Acc) ->
        case maps:is_key(K + 1, Count) of
            true -> max(Acc, maps:get(K, Count) + maps:get(K + 1, Count));
            false -> Acc
        end
    end, 0, maps:keys(Count)).