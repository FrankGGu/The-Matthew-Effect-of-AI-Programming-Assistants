-module(fascinating).
-export([is_fascinating/1]).

is_fascinating(N) ->
    S = integer_to_list(N),
    case length(S) of
        3 -> check(S, 1, 2, 3);
        _ -> false
    end.

check(S, A, B, C) ->
    case lists:member(integer_to_list(A), S) andalso lists:member(integer_to_list(B), S) andalso lists:member(integer_to_list(C), S) of
        true -> 
            case lists:usort(S) of
                [49,50,51] -> true;
                _ -> false
            end;
        false -> false
    end.