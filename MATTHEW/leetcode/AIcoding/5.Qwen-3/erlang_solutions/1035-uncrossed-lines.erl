-module(uv).
-export([uncrossed_lines/2]).

uncrossed_lines(A, B) ->
    N = length(A),
    M = length(B),
    DP = array:new(N+1, {default, 0}),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            case A--I of
                [H|_] when H == B--J ->
                    array:set(I+1, array:get(I, DP) + 1, DP);
                _ ->
                    array:set(I+1, max(array:get(I, DP), array:get(I-1, DP)), DP)
            end
        end, lists:seq(1, M))
    end, lists:seq(1, N)),
    array:get(N, DP).

-define(ARRAY_GET(A, I), element(I+1, A)).
-define(ARRAY_SET(A, I, V), setelement(I+1, A, V)).

-define(LIST_GET(L, I), lists:nth(I, L)).

(-) --> (A, B) -> ?LIST_GET(A, B).