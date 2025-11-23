-spec number_of_weeks(Milestones :: [integer()]) -> integer().
number_of_weeks(Milestones) ->
    Sum = lists:sum(Milestones),
    Max = lists:max(Milestones),
    case Max > Sum - Max of
        true -> 2 * (Sum - Max) + 1;
        false -> Sum
    end.