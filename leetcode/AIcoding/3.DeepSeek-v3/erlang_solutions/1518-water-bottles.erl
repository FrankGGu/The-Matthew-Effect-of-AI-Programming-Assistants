-spec num_water_bottles(NumBottles :: integer(), NumExchange :: integer()) -> integer().
num_water_bottles(NumBottles, NumExchange) ->
    drink(NumBottles, NumExchange, 0).

drink(Full, Exchange, Drank) when Full >= Exchange ->
    NewFull = Full div Exchange + Full rem Exchange,
    NewDrank = Drank + Full - Full rem Exchange,
    drink(NewFull, Exchange, NewDrank);
drink(Full, _Exchange, Drank) ->
    Drank + Full.