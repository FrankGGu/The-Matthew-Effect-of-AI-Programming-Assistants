-module(solution).
-export([num_subseqs/1]).

num_subseqs(Gcds) ->
    GcdsLength = length(Gcds),
    MaxGcd = lists:max(Gcds),
    Count = array:new([{size, MaxGcd + 1}, {default, 0}]),
    Result = 0,
    num_subseqs(Gcds, Count, Result).

num_subseqs([], _Count, Result) ->
    Result;
num_subseqs([Gcd | Rest], Count, Result) ->
    NewCount = array:update(Gcd, array:get(Gcd, Count) + 1, Count),
    SubResult = array:get(Gcd, NewCount),
    num_subseqs(Rest, NewCount, (Result + SubResult) rem 1000000007).

num_subseqs(_Gcds, _Count, _Result) ->
    0.