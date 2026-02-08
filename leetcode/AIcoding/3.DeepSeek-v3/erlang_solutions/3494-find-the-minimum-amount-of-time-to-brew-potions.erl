-spec brew_potions(Potions :: [integer()], BoilTime :: integer()) -> integer().
brew_potions(Potions, BoilTime) ->
    lists:max([lists:sum(Potions), BoilTime * length(Potions)]).