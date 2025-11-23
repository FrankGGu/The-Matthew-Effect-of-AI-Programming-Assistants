-module(solution).
-export([prefixesDivBy5/1]).

prefixesDivBy5(A) ->
    prefixesDivBy5(A, 0, []).

prefixesDivBy5([], _, Acc) ->
    lists:reverse(Acc);
prefixesDivBy5([H|T], P, Acc) ->
    NewP = rem(P * 2 + H, 5),
    prefixesDivBy5(T, NewP, [NewP == 0 || Acc]).