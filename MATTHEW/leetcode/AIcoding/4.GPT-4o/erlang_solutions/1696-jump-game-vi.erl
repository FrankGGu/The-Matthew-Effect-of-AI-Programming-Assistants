-module(solution).
-export([max_jumps/2]).

max_jumps(Nums, K) ->
    max_jumps_helper(Nums, K, length(Nums), lists:duplicate(length(Nums), -1), 0).

max_jumps_helper(Nums, K, N, Memo, Index) when Index >= N ->
    0;
max_jumps_helper(Nums, K, N, Memo, Index) ->
    case lists:nth(Index + 1, Memo) of
        -1 ->
            MaxJump = lists:foldl(fun(I, Acc) ->
                if 
                    I < Index -> Acc;
                    true -> 
                        NewIndex = Index + I,
                        if 
                            NewIndex >= N -> Acc;
                            true -> 
                                MaxNext = max_jumps_helper(Nums, K, N, Memo, NewIndex),
                                max(Acc, MaxNext + lists:nth(Index + 1, Nums))
                        end
                end
            end, 0, lists:sublist(Nums, Index + 1, min(K, N - Index))),

            NewMemo = lists:replace_at(Memo, Index + 1, MaxJump),
            MaxJump;
        MaxJump ->
            MaxJump
    end.