-module(solution).
-export([bus_rapid_transit/5]).

bus_rapid_transit(Target, Inc, Dec, Jump, Cost) ->
    memo_init(),
    Ans = dfs(Target, Inc, Dec, Jump, Cost),
    memo_clear(),
    Ans rem 1000000007.

dfs(0, _, _, _, _) -> 0;
dfs(1, Inc, _, _, _) -> Inc;
dfs(Target, Inc, Dec, Jump, Cost) ->
    case memo_get(Target) of
        {ok, Val} -> Val;
        error ->
            MinCost = case Target rem 2 of
                0 ->
                    Half = Target div 2,
                    min(dfs(Half, Inc, Dec, Jump, Cost) + Cost,
                        (Target - Half) * Inc + Cost);
                1 ->
                    Half1 = Target div 2,
                    Half2 = Half1 + 1,
                    min(min(dfs(Half1, Inc, Dec, Jump, Cost) + Cost + (Target - Half1 * 2) * Inc,
                             dfs(Half2, Inc, Dec, Jump, Cost) + Cost + (Half2 * 2 - Target) * Dec),
                        (Target - 1) * Inc)
            end,
            memo_put(Target, MinCost),
            MinCost
    end.

memo_init() ->
    put(memo, #{}).

memo_clear() ->
    erase(memo).

memo_get(Key) ->
    Memo = get(memo),
    case maps:find(Key, Memo) of
        {ok, Val} -> {ok, Val};
        error -> error
    end.

memo_put(Key, Val) ->
    Memo = get(memo),
    put(memo, maps:put(Key, Val, Memo)).