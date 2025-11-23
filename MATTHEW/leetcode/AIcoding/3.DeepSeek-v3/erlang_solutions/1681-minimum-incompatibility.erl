-module(solution).
-export([minimum_incompatibility/2]).

minimum_incompatibility(Nums, K) ->
    case length(Nums) rem K of
        0 -> ok;
        _ -> -1
    end,
    case lists:usort(Nums) of
        Nums when length(Nums) < K -> -1;
        _ ->
            case solve(Nums, K) of
                infinity -> -1;
                Res -> Res
            end
    end.

solve(Nums, K) ->
    Len = length(Nums),
    SubsetSize = Len div K,
    Sorted = lists:sort(Nums),
    solve(Sorted, SubsetSize, K, 0, 0, 0, 0, maps:new()).

solve(Sorted, SubsetSize, K, Index, Count, Last, Sum, Memo) ->
    case Count =:= SubsetSize of
        true ->
            case K =:= 1 of
                true -> Sum;
                false ->
                    case solve(Sorted, SubsetSize, K - 1, 0, 0, 0, Sum, Memo) of
                        infinity -> infinity;
                        NewSum -> NewSum
                    end
            end;
        false ->
            case Index >= length(Sorted) of
                true -> infinity;
                false ->
                    case maps:get(Index, Memo, not_used) of
                        not_used ->
                            case Count =:= 0 orelse (lists:nth(Index + 1, Sorted) > Last) of
                                true ->
                                    Num = lists:nth(Index + 1, Sorted),
                                    NewSum = case Count of
                                                0 -> Sum;
                                                _ -> Sum + Num - Last
                                            end,
                                    NewMemo = maps:put(Index, used, Memo),
                                    case solve(Sorted, SubsetSize, K, Index + 1, Count + 1, Num, NewSum, NewMemo) of
                                        infinity ->
                                            solve(Sorted, SubsetSize, K, Index + 1, Count, Last, Sum, Memo);
                                        Res1 ->
                                            case solve(Sorted, SubsetSize, K, Index + 1, Count, Last, Sum, Memo) of
                                                infinity -> Res1;
                                                Res2 -> min(Res1, Res2)
                                            end
                                    end;
                                false ->
                                    solve(Sorted, SubsetSize, K, Index + 1, Count, Last, Sum, Memo)
                            end;
                        _ ->
                            solve(Sorted, SubsetSize, K, Index + 1, Count, Last, Sum, Memo)
                    end
            end
    end.