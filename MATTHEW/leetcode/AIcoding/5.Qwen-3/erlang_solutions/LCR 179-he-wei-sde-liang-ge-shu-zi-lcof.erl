-module(solution).
-export([two_sum/2]).

two_sum(Prices, Target) ->
    two_sum(Prices, Target, 0, dict:new()).

two_sum([], _, _, _) ->
    [];
two_sum([Price | Rest], Target, Index, Dict) ->
    Complement = Target - Price,
    case dict:find(Complement, Dict) of
        {ok, ComplementIndex} ->
            [ComplementIndex, Index];
        error ->
            two_sum(Rest, Target, Index + 1, dict:store(Price, Index, Dict))
    end.