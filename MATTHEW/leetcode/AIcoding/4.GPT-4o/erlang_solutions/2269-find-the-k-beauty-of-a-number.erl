-module(solution).
-export([k_beauty/2]).

k_beauty(N, K) ->
    StrN = integer_to_list(N),
    StrLen = length(StrN),
    if
        StrLen < K -> 0;
        true -> 
            KBeautyCount = lists:foldl(fun(Index, Acc) ->
                SubStr = lists:sublist(StrN, Index, K),
                if
                    length(SubStr) < K -> Acc;
                    true -> 
                        Num = list_to_integer(SubStr),
                        if
                            Num =:= 0 -> Acc;
                            N rem Num =:= 0 -> Acc + 1;
                            true -> Acc
                        end
                end
            end, 0, lists:seq(1, StrLen - K + 1)),
            KBeautyCount
    end.