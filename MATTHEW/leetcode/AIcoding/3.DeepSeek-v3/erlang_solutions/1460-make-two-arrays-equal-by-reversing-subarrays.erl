-spec can_be_equal(Target :: [integer()], Arr :: [integer()]) -> boolean().
can_be_equal(Target, Arr) ->
    lists:sort(Target) =:= lists:sort(Arr).