-module(solution).
-export([canConvert/2]).

canConvert(A, B) ->
    canConvert(A, B, 0, erlang:length(A) - 1, 0, erlang:length(B) - 1).

canConvert(_, _, I, J, K, L) when I > J, K > L -> true;
canConvert(_, _, I, J, K, L) when I > J -> check(B, K, L);
canConvert(_, _, I, J, K, L) when K > L -> check(A, I, J);
canConvert(A, B, I, J, K, L) ->
    case (erlang:element(I + 1, A) == erlang:element(K + 1, B)) of
        true ->
            canConvert(A, B, I + 1, J, K + 1, L);
        false ->
            case (erlang:element(J + 1, A) == erlang:element(L + 1, B)) of
                true ->
                    canConvert(A, B, I, J - 1, K, L - 1);
                false ->
                    false
            end
    end.

check(S, I, J) ->
    check(S, I, J, 0).

check(S, I, J, N) when N >= (J - I + 1) div 2 -> true;
check(S, I, J, N) ->
    case erlang:element(I + N + 1, S) == erlang:element(J - N + 1, S) of
        true -> check(S, I, J, N + 1);
        false -> false
    end.