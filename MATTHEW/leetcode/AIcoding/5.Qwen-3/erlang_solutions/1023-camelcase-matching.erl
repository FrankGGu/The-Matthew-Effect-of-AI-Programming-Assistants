-module(camelcase_matching).
-export([camelMatch/2]).

camelMatch(Pattern, Strings) ->
    [match(Pattern, S) || S <- Strings].

match(_, []) ->
    true;
match([], _) ->
    false;
match([P | Pt], [C | Ct]) ->
    case P of
        C ->
            match(Pt, Ct);
        _ when is_upper(C) ->
            false;
        _ ->
            match([P | Pt], Ct)
    end.