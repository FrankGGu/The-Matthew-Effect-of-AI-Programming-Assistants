-spec bulb_switch(N :: integer()) -> integer().
bulb_switch(N) ->
    round(sqrt(N)).

round(X) when X < 0 -> 0;
round(X) -> trunc(X).
