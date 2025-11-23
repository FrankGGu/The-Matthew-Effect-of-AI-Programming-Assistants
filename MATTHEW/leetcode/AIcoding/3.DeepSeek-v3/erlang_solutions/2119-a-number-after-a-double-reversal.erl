-spec is_same_after_reversals(Num :: integer()) -> boolean().
is_same_after_reversals(Num) ->
    Num == 0 orelse Num rem 10 =/= 0.