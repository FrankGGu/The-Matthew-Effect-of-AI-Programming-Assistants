-module(min_operations_equal_frequency).
-export([min_operations/1]).

min_operations(S) ->
  Counts = lists:foldl(fun(C, Acc) ->
                maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
            end, #{}, S),
  Values = maps:values(Counts),
  Frequencies = lists:foldl(fun(V, Acc) ->
                    maps:update_with(V, fun(K) -> K + 1 end, 1, Acc)
                end, #{}, Values),
  min_ops(Values, Frequencies, length(S)).

min_ops(Values, Frequencies, Len) ->
  lists:foldl(fun(TargetFreq, Acc) ->
                    case maps:is_key(TargetFreq, Frequencies) of
                      true ->
                        FreqCount = maps:get(TargetFreq, Frequencies),
                        Ops = Len - FreqCount * TargetFreq,
                        min(Acc, Ops);
                      false ->
                        Acc
                    end
                end, Len, [1] ++ lists:seq(1, Len)).