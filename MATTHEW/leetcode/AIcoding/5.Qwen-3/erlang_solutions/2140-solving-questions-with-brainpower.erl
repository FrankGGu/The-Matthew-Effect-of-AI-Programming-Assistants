-module(solving_questions_with_brainpower).
-export([solve/1]).

solve(Questions) ->
    solve(Questions, 0, dict:new()).

solve([], _Index, _Cache) ->
    0;
solve(Questions, Index, Cache) ->
    case dict:is_key(Index, Cache) of
        true ->
            dict:fetch(Index, Cache);
        false ->
            [ {Points, Brainpower} | Rest ] = lists:nth(Index + 1, Questions),
            Take = Points + solve(Questions, Index + Brainpower + 1, Cache),
            NotTake = solve(Questions, Index + 1, Cache),
            Max = max(Take, NotTake),
            NewCache = dict:store(Index, Max, Cache),
            Max
    end.