-module(maximum_number).
-export([max_number/2]).

max_number(Nums, K) ->
    lists:reverse(create_max_number(lists:reverse(Nums), K)).

create_max_number(_, 0) ->
    [];
create_max_number([H | T], K) ->
    case length(T) >= K - 1 of
        true ->
            [H | create_max_number(T, K - 1)];
        false ->
            create_max_number(T, K)
    end.