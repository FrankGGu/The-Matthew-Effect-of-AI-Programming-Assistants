-module(solution).
-export([smallest_good_base/1]).

smallest_good_base(N) ->
    NNum = list_to_integer(N),
    MaxM = trunc(math:log2(NNum + 1)),
    lists:min(lists:flatten([find_base(NNum, M) || M <- lists:seq(MaxM, 2, -1)]) ++ [NNum - 1]).

find_base(N, M) ->
    K = trunc(math:pow(N, 1.0 / M)),
    case (math:pow(K, M + 1) - 1) / (K - 1) of
        Sum when abs(Sum - N) < 1.0e-9 -> [K];
        _ -> []
    end.