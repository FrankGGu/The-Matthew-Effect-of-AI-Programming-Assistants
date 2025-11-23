-spec get_min_distance(Nums :: [integer()], Target :: integer(), Start :: integer()) -> integer().
get_min_distance(Nums, Target, Start) ->
    Indices = [I || {I, X} <- lists:zip(lists:seq(0, length(Nums) - 1), Nums), X =:= Target],
    lists:min([abs(I - Start) || I <- Indices]).