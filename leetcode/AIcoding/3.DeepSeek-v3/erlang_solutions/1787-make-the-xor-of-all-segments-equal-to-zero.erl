-module(solution).
-export([min_changes/2]).

min_changes(Nums, K) ->
    min_changes(Nums, K).

min_changes(Nums, K) ->
    Counts = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Nums),
    DP = maps:from_list([{X, 0} || X <- lists:seq(0, 1023)]),
    DP1 = lists:foldl(fun(I, D) ->
                        lists:foldl(fun(X, Acc) ->
                                        Max = 0,
                                        lists:foldl(fun(J, M) ->
                                                        Y = X bxor J,
                                                        case I - K >= 0 of
                                                            true ->
                                                                case maps:get(Y, D, 0) of
                                                                    undefined -> M;
                                                                    V -> max(M, V)
                                                                end;
                                                            false -> M
                                                        end
                                                    end, Max, lists:seq(0, 1023)),
                                        case I - K >= 0 of
                                            true ->
                                                case maps:get(X, Counts, 0) of
                                                    undefined -> Acc;
                                                    C -> maps:put(X, max(maps:get(X, Acc, 0), Max + C), Acc)
                                                end;
                                            false -> Acc
                                        end
                                    end, D, lists:seq(0, 1023))
                      end, DP, lists:seq(0, length(Nums) - 1)),
    Total = length(Nums),
    Total - maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, DP1).