-spec find_array(Pref :: [integer()]) -> [integer()].
find_array(Pref) ->
    find_array(Pref, 0, []).

find_array([], _, Acc) ->
    lists:reverse(Acc);
find_array([H|T], Prev, Acc) ->
    Current = H bxor Prev,
    find_array(T, H, [Current|Acc]).