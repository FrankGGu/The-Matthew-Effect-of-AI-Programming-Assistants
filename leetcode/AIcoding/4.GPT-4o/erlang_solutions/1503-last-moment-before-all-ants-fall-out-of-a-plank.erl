-module(solution).
-export([getLastMoment/3]).

getLastMoment(N, left, right) when left > right ->
    max(N, right);
getLastMoment(N, left, right) ->
    max(N - left, right).