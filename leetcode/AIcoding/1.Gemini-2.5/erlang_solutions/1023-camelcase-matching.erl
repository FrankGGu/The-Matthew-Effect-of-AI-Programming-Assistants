-module(solution).
-export([camelMatch/2]).

camelMatch(Queries, Pattern) ->
    lists:map(fun(Query) -> match(Query, Pattern) end, Queries).

match(Query, Pattern) ->
    match_recursive(Query, Pattern).

match_recursive([], []) ->
    true;
match_recursive(Q, []) ->
    all_lower(Q);
match_recursive([], _) ->
    false;
match_recursive([QH | QT], [PH | PT]) ->
    if
        QH == PH ->
            match_recursive(QT, PT);
        is_upper(QH) ->
            false;
        true ->
            match_recursive(QT, [PH | PT])
    end.

is_upper(Char) when Char >= $A andalso Char =< $Z ->
    true;
is_upper(_) ->
    false.

is_lower(Char) when Char >= $a andalso Char =< $z ->
    true;
is_lower(_) ->
    false.

all_lower([]) ->
    true;
all_lower([H | T]) ->
    is_lower(H) andalso all_lower(T).