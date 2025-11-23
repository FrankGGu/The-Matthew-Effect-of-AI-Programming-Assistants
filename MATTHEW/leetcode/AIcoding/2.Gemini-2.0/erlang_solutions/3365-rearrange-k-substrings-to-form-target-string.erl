-module(rearrange_k_substrings).
-export([canRearrange]).

canRearrange(S, Target, K) ->
  S_counts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, S),
  Target_counts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, Target),
  case lists:all(fun(C) -> maps:get(C, S_counts, 0) >= maps:get(C, Target_counts, 0) end, maps:keys(Target_counts)) of
    true ->
      Max_freq = lists:max([maps:get(C, Target_counts) || C <- maps:keys(Target_counts)]),
      Max_freq * K =< length(S);
    false ->
      false
  end.