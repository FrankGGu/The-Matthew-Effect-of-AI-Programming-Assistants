-module(solution).
-export([count_valid_pickup_delivery/1]).

count_valid_pickup_delivery(N) ->
    count_valid_pickup_delivery(N, 1, 1).

count_valid_pickup_delivery(0, _, _) ->
    1;
count_valid_pickup_delivery(N, I, J) ->
    (2 * N - I + 1) * (2 * N - J + 1) * count_valid_pickup_delivery(N - 1, I + 1, J + 1).