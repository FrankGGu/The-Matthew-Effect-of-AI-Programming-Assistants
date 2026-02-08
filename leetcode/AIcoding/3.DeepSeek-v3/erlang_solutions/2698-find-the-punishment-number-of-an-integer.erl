-module(solution).
-export([punishment_number/1]).

punishment_number(N) ->
    lists:sum([X * X || X <- lists:seq(1, N), is_punishment(X)]).

is_punishment(X) ->
    S = integer_to_list(X * X),
    check_partitions(S, X).

check_partitions(S, Target) ->
    case S of
        [] -> Target == 0;
        _ ->
            lists:any(fun(I) ->
                {Prefix, Rest} = lists:split(I, S),
                Num = list_to_integer(Prefix),
                Num =< Target andalso check_partitions(Rest, Target - Num)
            end, lists:seq(1, length(S)))
    end.