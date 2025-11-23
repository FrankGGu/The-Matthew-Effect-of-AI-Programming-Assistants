-module(solution).
-export([find_indices/2]).

find_indices(Numbers, Target) ->
    find_indices(Numbers, Target, 0, dict:new()).

find_indices([], _Target, _Index, _Dict) ->
    [];
find_indices([Num | Rest], Target, Index, Dict) ->
    Complement = Target - Num,
    case dict:is_key(Complement, Dict) of
        true ->
            [dict:fetch(Complement, Dict), Index];
        false ->
            find_indices(Rest, Target, Index + 1, dict:store(Num, Index, Dict))
    end.