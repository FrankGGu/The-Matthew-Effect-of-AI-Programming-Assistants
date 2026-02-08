-spec bulb_switch(N :: integer()) -> integer().
bulb_switch(N) ->
    trunc(math:sqrt(N)).