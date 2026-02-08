-spec ways_to_buy_pens_pencils(Total :: integer(), Cost1 :: integer(), Cost2 :: integer()) -> integer().
ways_to_buy_pens_pencils(Total, Cost1, Cost2) ->
    MaxPens = Total div Cost1,
    lists:sum([(Total - Pens * Cost1) div Cost2 + 1 || Pens <- lists:seq(0, MaxPens)]).