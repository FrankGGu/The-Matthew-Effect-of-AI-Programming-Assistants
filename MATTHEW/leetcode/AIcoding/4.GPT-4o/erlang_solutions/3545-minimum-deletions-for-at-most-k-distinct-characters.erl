-module(solution).
-export([min_deletions/2]).

min_deletions(Str, K) ->
    N = string:len(Str),
    CharCount = maps:fold(fun(_, Val, Acc) -> maps:update(Val, maps:get(Val, Acc, 0) + 1, Acc) end,
                          maps:new(), 
                          string:to_list(Str)),
    DistinctChars = maps:size(CharCount),
    case DistinctChars > K of
        false -> 0;
        true ->
            SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A < B end, maps:to_list(CharCount)),
            Excess = DistinctChars - K,
            lists:foldl(fun({_, Count}, Acc) ->
                            if
                                Acc < Excess ->
                                    Acc + 1;
                                true ->
                                    Acc
                            end
                         end,
                         0,
                         SortedCounts)
    end.