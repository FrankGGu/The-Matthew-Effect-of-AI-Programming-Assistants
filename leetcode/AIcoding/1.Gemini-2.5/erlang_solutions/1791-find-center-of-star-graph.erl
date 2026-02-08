-module(solution).
-export([find_center/1]).

find_center([[U1, V1], [U2, V2] | _]) when U1 == U2; U1 == V2 ->
    U1;
find_center([[_, V1], _, _ | _]) ->
    V1.