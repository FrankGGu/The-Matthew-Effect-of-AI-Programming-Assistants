-spec number_of_weeks(Milestones :: [integer()]) -> integer().
number_of_weeks(Milestones) ->
    Sum = lists:sum(Milestones),
    Max = lists:max(Milestones),
    min(Sum, 2 * (Sum - Max) + 1).