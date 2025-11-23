-module(solution).
-export([stone_game_vi/1]).

stone_game_vi(Piles) ->
    {Alice, Bob} = lists:foldl(fun({A, B}, {AccA, AccB}) -> 
                                    {AccA + A, AccB + B}
                                end, {0, 0}, lists:sort(fun({A1, B1}, {A2, B2}) -> A1 + B1 > A2 + B2 end, Piles)),
    case Alice > Bob of
        true -> 1;
        false -> case Alice < Bob of
            true -> -1;
            false -> 0
        end
    end.