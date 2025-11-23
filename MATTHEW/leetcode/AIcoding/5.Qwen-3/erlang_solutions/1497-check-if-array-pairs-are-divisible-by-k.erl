-module(solution).
-export([can_divide_by_k/2]).

can_divide_by_k(Numbers, K) ->
    Map = lists:foldl(fun(N, Acc) ->
        Key = N rem K,
        Count = maps:get(Key, Acc, 0),
        maps:put(Key, Count + 1, Acc)
    end, #{}, Numbers),
    check_pairs(Map, K).

check_pairs(Map, K) ->
    lists:all(fun({Key, Count}) ->
        if
            Key == 0 -> Count rem 2 == 0;
            true ->
                PairKey = (K - Key) rem K,
                case maps:find(PairKey, Map) of
                    {ok, PairCount} -> Count == PairCount;
                    _ -> false
                end
        end
    end, maps:to_list(Map)).