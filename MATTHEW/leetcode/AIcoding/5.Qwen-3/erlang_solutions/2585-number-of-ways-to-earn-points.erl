-module(number_of_ways_to_earn_points).
-export([number_of_ways/2]).

number_of_ways(Points, K) ->
    Ways = 0,
    number_of_ways(Points, K, Ways).

number_of_ways([], _, Ways) ->
    Ways;
number_of_ways([P | T], K, Ways) ->
    Count = count_ways(P, K),
    number_of_ways(T, K, Ways + Count).

count_ways(P, K) ->
    count_ways(P, K, 0, 0).

count_ways(_, 0, Total, _) ->
    Total;
count_ways(P, K, Total, Current) when Current > P ->
    Total;
count_ways(P, K, Total, Current) ->
    count_ways(P, K - 1, Total + 1, Current + 1).