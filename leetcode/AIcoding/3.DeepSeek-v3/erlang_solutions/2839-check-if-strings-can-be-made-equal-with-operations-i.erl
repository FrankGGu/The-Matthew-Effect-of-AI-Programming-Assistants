-spec can_be_equal(Target :: unicode:unicode_binary(), S :: unicode:unicode_binary()) -> boolean().
can_be_equal(Target, S) ->
    TargetList = binary_to_list(Target),
    SList = binary_to_list(S),
    lists:sort(TargetList) =:= lists:sort(SList).