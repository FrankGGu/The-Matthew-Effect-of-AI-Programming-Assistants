-spec max_ice_cream(Costs :: [integer()], Coins :: integer()) -> integer().
max_ice_cream(Costs, Coins) ->
    Sorted = lists:sort(Costs),
    count_ice_creams(Sorted, Coins, 0).

count_ice_creams([], _, Count) -> Count;
count_ice_creams([Cost | Rest], Coins, Count) when Cost =< Coins ->
    count_ice_creams(Rest, Coins - Cost, Count + 1);
count_ice_creams(_, _, Count) -> Count.