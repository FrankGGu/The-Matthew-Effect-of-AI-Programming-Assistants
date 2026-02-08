-spec build_array(Target :: [integer()], N :: integer()) -> [unicode:unicode_binary()].
build_array(Target, N) ->
    build_array(Target, 1, []).

build_array([], _, Acc) ->
    lists:reverse(Acc);
build_array([H | T], Current, Acc) when H =:= Current ->
    build_array(T, Current + 1, [<<"Push">> | Acc]);
build_array([H | _] = Target, Current, Acc) when H > Current ->
    build_array(Target, Current + 1, [<<"Pop">>, <<"Push">> | Acc]).