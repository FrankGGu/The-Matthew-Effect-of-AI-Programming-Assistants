-spec expect_number(Probabilities :: [float()]) -> float().
expect_number(Probabilities) ->
    Unique = lists:usort(Probabilities),
    length(Unique).