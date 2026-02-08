-spec distribute_candies(Candies :: [integer()]) -> integer().
distribute_candies(Candies) ->
    Unique = sets:size(sets:from_list(Candies)),
    Total = length(Candies),
    min(Unique, Total div 2).