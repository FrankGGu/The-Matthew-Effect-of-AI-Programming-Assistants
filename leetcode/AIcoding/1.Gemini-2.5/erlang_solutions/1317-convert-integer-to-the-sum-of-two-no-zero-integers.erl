-module(solution).
-export([get_no_zero_integers/1]).

is_no_zero(N) when N > 0 ->
    not lists:member($0, integer_to_list(N)).

get_no_zero_integers(N) ->
    get_no_zero_integers(N, 1).

get_no_zero_integers(N, A) ->
    B = N - A,
    case is_no_zero(A) andalso is_no_zero(B) of
        true ->
            {A, B};
        false ->
            get_no_zero_integers(N, A + 1)
    end.