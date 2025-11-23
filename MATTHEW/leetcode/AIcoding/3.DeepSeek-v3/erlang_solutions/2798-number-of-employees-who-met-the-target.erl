-spec count_employees_met_target(Hours :: [integer()], Target :: integer()) -> integer().
count_employees_met_target(Hours, Target) ->
    length([H || H <- Hours, H >= Target]).