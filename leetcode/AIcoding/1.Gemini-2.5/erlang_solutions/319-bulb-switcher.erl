-spec bulb_switcher(N :: integer()) -> integer().
bulb_switcher(N) when N < 0 -> 0;
bulb_switcher(N) ->
    trunc(math:sqrt(N)).