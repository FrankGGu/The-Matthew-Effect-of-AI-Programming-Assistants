-spec distribute_candies(Candies :: integer(), Num_people :: integer()) -> [integer()].
distribute_candies(Candies, Num_people) ->
    distribute_candies(Candies, Num_people, 1, lists:duplicate(Num_people, 0)).

distribute_candies(0, _, _, Result) ->
    Result;
distribute_candies(Candies, Num_people, Turn, Result) ->
    Give = min(Turn, Candies),
    Index = (Turn - 1) rem Num_people + 1,
    NewResult = update_list(Result, Index, Give),
    distribute_candies(Candies - Give, Num_people, Turn + 1, NewResult).

update_list(List, Index, Value) ->
    {Left, [Old | Right]} = lists:split(Index - 1, List),
    Left ++ [Old + Value | Right].