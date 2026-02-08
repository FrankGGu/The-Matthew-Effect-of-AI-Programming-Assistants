-module(solution).
-export([maxOperations/2]).

maxOperations(Nums, K) ->
    lists:foldl(
        fun(N, Acc) ->
            #{count := Count, freq_map := FreqMap} = Acc,
            Complement = K - N,
            case gb_trees:lookup(Complement, FreqMap) of
                {ok, Cnt} when Cnt > 0 ->
                    NewFreqMap = gb_trees:insert(Complement, Cnt - 1, FreqMap),
                    #{count := Count + 1, freq_map := NewFreqMap};
                _ ->
                    CurrentNCount = case gb_trees:lookup(N, FreqMap) of
                                        {ok, CntN} -> CntN;
                                        _ -> 0
                                    end,
                    NewFreqMap = gb_trees:insert(N, CurrentNCount + 1, FreqMap),
                    #{count := Count, freq_map := NewFreqMap}
            end
        end,
        #{count := 0, freq_map := gb_trees:empty()},
        Nums
    )#{count}.