-module(solution).
-export([numberOfPeopleAwareOfSecret/2]).

numberOfPeopleAwareOfSecret(N, K) ->
    People = array:new([{size, N}, {default, 0}]),
    array:set(1, 1, People),
    do(N, K, 1, array:set(1, 1, People)).

do(N, K, T, People) when T >= N ->
    array:get(N, People);
do(N, K, T, People) ->
    Current = array:get(T, People),
    if
        Current > 0 ->
            Next = T + K,
            if
                Next <= N ->
                    NewPeople = array:set(Next, array:get(Next, People) + Current, People),
                    do(N, K, T + 1, NewPeople);
                true ->
                    do(N, K, T + 1, People)
            end;
        true ->
            do(N, K, T + 1, People)
    end.