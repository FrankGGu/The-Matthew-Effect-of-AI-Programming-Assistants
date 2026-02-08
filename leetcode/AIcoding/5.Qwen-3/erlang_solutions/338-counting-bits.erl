-module(counting_bits).
-export([count_bits/1]).

count_bits(N) ->
    count_bits(N, 0, []).

count_bits(0, _, Acc) ->
    lists:reverse(Acc);
count_bits(N, I, Acc) ->
    Count = count_ones(I),
    count_bits(N - 1, I + 1, [Count | Acc]).

count_ones(0) ->
    0;
count_ones(N) ->
    (N band 1) + count_ones(N bsr 1).