-module(solution).
-export([count_k_subsequences_with_max_beauty/2]).

count_k_subsequences_with_max_beauty(S, K) ->
    case length(S) < K of
        true -> 0;
        false ->
            FreqMap = frequency_map(S),
            FreqList = lists:reverse(lists:sort(maps:values(FreqMap))),
            case length(FreqList) < K of
                true -> 0;
                false ->
                    M = lists:nth(K, FreqList),
                    R = lists:filter(fun(X) -> X == M end, FreqList),
                    L = lists:filter(fun(X) -> X > M end, FreqList),
                    T = length(R),
                    C = length(L),
                    Comb = comb(T, K - C),
                    lists:foldl(fun(X, Acc) -> (Acc * X) rem 1000000007 end, Comb, lists:sublist(FreqList, C) ++ lists:duplicate(K - C, M))
            end
    end.

frequency_map(S) ->
    lists:foldl(fun(Char, Map) -> 
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Map) 
    end, #{}, S).

comb(N, K) when K > N -> 0;
comb(_, 0) -> 1;
comb(N, K) when K > N - K -> comb(N, N - K);
comb(N, K) ->
    lists:foldl(fun(I, Acc) -> (Acc * (N - I + 1) div I) rem 1000000007 end, 1, lists:seq(1, K)).