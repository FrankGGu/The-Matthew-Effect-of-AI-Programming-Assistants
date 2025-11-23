-module(solution).
-export([two_sum/2]).

two_sum(Prices, Target) ->
    solve(Prices, Target, 0, dict:new()).

solve([], _Target, _Index, _Map) ->
    [];
solve([H|T], Target, CurrentIndex, Map) ->
    Complement = Target - H,
    case dict:find(Complement, Map) of
        {ok, ComplementIndex} ->
            [ComplementIndex, CurrentIndex];
        error ->
            NewMap = dict:store(H, CurrentIndex, Map),
            solve(T, Target, CurrentIndex + 1, NewMap)
    end.