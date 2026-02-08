-module(solution).
-export([generate_the_string/1]).

generate_the_string(N) when N > 0 ->
    if N rem 2 =:= 1 ->
        lists:duplicate(N, $a);
    true ->
        lists:append(lists:duplicate(N - 1, $a), [$b])
    end.