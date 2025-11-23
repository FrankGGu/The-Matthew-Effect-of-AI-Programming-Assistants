-module(best_sightseeing_pair).
-export([max_score_sightseeing/1]).

max_score_sightseeing(Prices) ->
    {Max, _} = lists:foldl(fun(Price, {CurrentMax, Prev}) ->
        NewCurrentMax = max(CurrentMax, Prev + Price),
        {NewCurrentMax, Price}
    end, {0, 0}, Prices),
    Max.