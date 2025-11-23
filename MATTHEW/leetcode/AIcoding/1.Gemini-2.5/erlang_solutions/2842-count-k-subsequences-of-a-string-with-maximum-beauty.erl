-module(solution).
-export([countKSubsequencesWithMaxBeauty/2]).

countKSubsequencesWithMaxBeauty(S, K) ->
    FreqMap = lists:foldl(fun(Char, AccMap) ->
                                  maps:update_with(Char, fun(Val) -> Val + 1 end, 1, AccMap)
                          end, maps:new(), S),

    Frequencies = maps:values(FreqMap),
    SortedFrequencies = lists:sort(fun(A, B) -> A >= B end, Frequencies),

    case length(SortedFrequencies) < K of
        true -> 0;
        false ->
            Val_k = lists:nth(K, SortedFrequencies),

            CountGT = length([F | F <- SortedFrequencies, F > Val_k]),
            CountEQ = length([F | F <- SortedFrequencies, F == Val_k]),

            combinations(CountEQ, K - CountGT)
    end.

combinations(N, K) when K < 0 -> 0;
combinations(N, K) when K > N -> 0;
combinations(N, K) when K == 0 -> 1;
combinations(N, K) when K == N -> 1;
combinations(N, K) ->
    ActualK = min(K, N - K),
    combinations_iter(N, ActualK, 1, 1).

combinations_iter(N, K, Num, Den) when K == 0 -> Num div Den;
combinations_iter(N, K, Num, Den) ->
    combinations_iter(N - 1, K - 1, Num * N, Den * K).