-spec kids_with_candies(Candies :: [integer()], ExtraCandies :: integer()) -> [boolean()].
kids_with_candies(Candies, ExtraCandies) ->
    Max = lists:max(Candies),
    lists:map(fun(Candy) -> Candy + ExtraCandies >= Max end, Candies).