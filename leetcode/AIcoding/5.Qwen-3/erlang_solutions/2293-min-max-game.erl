-module(min_max_game).
-export([min_max_game/1]).

min_max_game(Nums) ->
    min_max_game_helper(Nums).

min_max_game_helper([X]) ->
    X;
min_max_game_helper(Nums) ->
    Len = length(Nums),
    NewNums = lists:map(fun(I) ->
        A = lists:nth(I*2+1, Nums),
        B = lists:nth(I*2+2, Nums),
        if
            I rem 2 == 0 ->
                min(A, B);
            true ->
                max(A, B)
        end
    end, lists:seq(0, (Len div 2) - 1)),
    min_max_game_helper(NewNums).