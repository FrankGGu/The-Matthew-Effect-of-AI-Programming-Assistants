-module(solution).
-export([max_happy_groups/2]).

max_happy_groups(BatchSize, Groups) ->
    Counts = lists:foldl(fun(X, Acc) ->
                            maps:update_with(X rem BatchSize, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Groups),
    dfs(Counts, BatchSize, 0, #{}).

dfs(Counts, BatchSize, Remain, Memo) ->
    Key = {Counts, Remain},
    case maps:get(Key, Memo, undefined) of
        undefined ->
            Max = case maps:size(Counts) of
                      0 -> 0;
                      _ ->
                          lists:max(
                            lists:map(
                              fun({R, C}) ->
                                      NewCounts = case C - 1 of
                                                      0 -> maps:remove(R, Counts);
                                                      N -> maps:put(R, N, Counts)
                                                  end,
                                      NewRemain = (Remain + R) rem BatchSize,
                                      Val = if NewRemain == 0 -> 1; true -> 0 end,
                                      Val + dfs(NewCounts, BatchSize, NewRemain, Memo)
                              end,
                              maps:to_list(Counts)))
                  end,
            maps:put(Key, Max, Memo),
            Max;
        Val -> Val
    end.