-module(solution).
-export([is_fuzzy_match/2]).

is_fuzzy_match(S, P) ->
    check(S, P).

check(_, []) -> true;
check([], _) -> false;
check([HS|TS], [HP|TP]) when HS == HP ->
    check(TS, TP);
check([_HS|TS], P) ->
    check(TS, P).