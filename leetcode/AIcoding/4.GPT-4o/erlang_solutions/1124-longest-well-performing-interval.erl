-module(solution).
-export([longest_well_performing_interval/1]).

longest_well_performing_interval/1 ->
    receive
        {ok, hours} ->
            N = length(hours),
            PrefixSum = lists:foldl(fun(X, Acc) -> Acc + if X > 8 -> 1; true -> -1 end end, 0, hours),
            Map = maps:fold(fun(_, Acc, _) -> maps:update_with(Acc, PrefixSum, fun(X) -> X + 1 end, 1) end, maps:empty(), lists:seq(1, N)),
            lists:max(lists:map(fun(Value) -> case maps:get(Value, Map, 0) of 0 -> 0; _ -> Value end end, lists:seq(1, N)))
    end.