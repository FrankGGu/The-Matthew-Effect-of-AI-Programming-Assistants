-module(solution).
-export([get_no_zero_integers/1]).

get_no_zero_integers(N) ->
    lists:foldl(fun(X, Acc) ->
        if
            is_no_zero(X) andalso is_no_zero(N - X) ->
                {X, N - X};
            true ->
                Acc
        end
    end, {0, 0}, lists:seq(1, N div 2 + 1).

is_no_zero(X) ->
    X =:= 0 orelse not lists:any(fun(C) -> C =:= $\0 end, unicode:characters_to_list(integer_to_list(X))).