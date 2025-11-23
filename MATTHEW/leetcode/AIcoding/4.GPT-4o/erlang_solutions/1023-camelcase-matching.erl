-module(solution).
-export([camelcase_matching/2]).

camelcase_matching(Patterns, Query) ->
    lists:map(fun(P) -> match(P, Query) end, Patterns).

match(Pattern, Query) ->
    case match_pattern(Pattern, Query, 0, 0) of
        true -> case is_lowercase_remaining(Pattern, Query, 0, 0) of
                  true -> true;
                  false -> false
                 end;
        _ -> false
    end.

match_pattern([], [] , _, _) ->
    true;
match_pattern([], _ , _, _) ->
    false;
match_pattern(_, []) ->
    false;
match_pattern([P | Ps], [Q | Qs], PIndex, QIndex) when P == Q ->
    match_pattern(Ps, Qs, PIndex + 1, QIndex + 1);
match_pattern([P | Ps], [Q | Qs], PIndex, QIndex) when is_upper(P) ->
    false;
match_pattern([P | Ps], [Q | Qs], PIndex, QIndex) ->
    match_pattern([P | Ps], Qs, PIndex, QIndex + 1).

is_lowercase_remaining(Pattern, Query, PIndex, QIndex) ->
    lists:all(fun(X) -> is_lower(X) end, lists:sublist(Pattern, PIndex)) andalso
    lists:all(fun(X) -> is_lower(X) end, lists:sublist(Query, QIndex)).

is_upper(Char) ->
    Char >= $A, Char =< $Z.

is_lower(Char) ->
    Char >= $a, Char =< $z.