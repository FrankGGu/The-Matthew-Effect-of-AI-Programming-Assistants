-spec count_odds(Low :: integer(), High :: integer()) -> integer().
count_odds(Low, High) ->
    (High - Low + 1 + Low rem 2) div 2.