-module(camelcase_matching).
-export([camelMatch/2]).

camelMatch(Queries, Pattern) ->
    lists:map(fun(Query) -> match(Query, Pattern) end, Queries).

match(Query, Pattern) ->
    match_helper(Query, Pattern, []).

match_helper([], [], Acc) ->
    true;
match_helper([], Pattern, Acc) ->
    case lists:all(fun(C) -> not is_uppercase(C) end, Pattern) of
        true -> true;
        false -> false
    end;
match_helper(Query, [], Acc) ->
    case lists:all(fun(C) -> not is_uppercase(C) end, Query) of
        true -> false;
        false -> false
    end;
match_helper([Q | QRest], [P | PRest], Acc) ->
    case (Q == P) of
        true -> match_helper(QRest, PRest, [Q | Acc]);
        false ->
            case is_uppercase(Q) of
                true -> false;
                false -> match_helper(QRest, [P | PRest], Acc)
            end
    end.

is_uppercase(C) ->
    C >= $A andalso C =< $Z.