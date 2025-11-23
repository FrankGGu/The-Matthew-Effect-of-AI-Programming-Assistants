-spec count_target(Scores :: [integer()], Target :: integer()) -> integer().
count_target(Scores, Target) ->
    length([X || X <- Scores, X =:= Target]).