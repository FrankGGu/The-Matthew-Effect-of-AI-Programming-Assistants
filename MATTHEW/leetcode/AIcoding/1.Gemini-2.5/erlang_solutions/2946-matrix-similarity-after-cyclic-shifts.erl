-module(solution).
-export([solution/2]).

solution(Mat, K) ->
    N = length(hd(Mat)),
    (K rem N) == 0.