-module(two_sum).
-export([two_sum/2]).

two_sum(Numbers, Target) ->
    two_sum(Numbers, Target, 0, dict:new()).

two_sum([], _Target, _Index, _Dict) ->
    [];
two_sum([Num | Rest], Target, Index, Dict) ->
    Complement = Target - Num,
    case dict:find(Complement, Dict) of
        {ok, ComplementIndex} ->
            [ComplementIndex, Index];
        error ->
            two_sum(Rest, Target, Index + 1, dict:store(Num, Index, Dict))
    end.