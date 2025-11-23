-module(solution).
-export([tilingRectangle/2]).

tilingRectangle(N, M) when N > M -> tilingRectangle(M, N).
tilingRectangle(0, 0) -> 0;
tilingRectangle(N, M) -> 
    case N == M of
        true -> 1;
        false -> 
            Min = lists:min([tilingRectangle(N - i, M - i) + 1 || i <- lists:seq(1, min(N, M))]),
            Min
    end.