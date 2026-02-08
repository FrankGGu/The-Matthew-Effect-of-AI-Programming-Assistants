-module(non_negative_integers_without_consecutive_ones).
-export([count_ones/1]).

count_ones(N) ->
    count_ones(N, 0, 1, 0).

count_ones(0, _, _, _) ->
    0;
count_ones(N, State, Power, Result) when State == 0 ->
    count_ones(N, 1, Power * 2, Result + Power);
count_ones(N, State, Power, Result) when State == 1 ->
    count_ones(N, 0, Power * 2, Result + Power);
count_ones(N, State, Power, Result) when N >= Power ->
    count_ones(N - Power, 1, Power * 2, Result + Power);
count_ones(_, _, _, Result) ->
    Result.