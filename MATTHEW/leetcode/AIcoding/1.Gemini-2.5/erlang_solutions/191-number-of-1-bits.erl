-module(solution).
-export([hammingWeight/1]).

-spec hammingWeight(N :: integer()) -> integer().
hammingWeight(N) ->
    count_set_bits(N, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(N, Count) ->
    NewCount = if
                   (N band 1) == 1 -> Count + 1;
                   true -> Count
               end,
    count_set_bits(N bsr 1, NewCount).