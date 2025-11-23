-module(solution).
-export([catMouseGame/1]).

catMouseGame(Moves) ->
    N = length(Moves),
    memo(Moves, 1, 2, 0, N).

memo(_, Cat, Mouse, Turn, N) when Mouse =:= 0 -> 1;
memo(_, Cat, Mouse, Turn, N) when Cat =:= Mouse -> 2;
memo(_, Cat, Mouse, Turn, N) when Turn =:= N -> 0;
memo(Moves, Cat, Mouse, Turn, N) ->
    case ets:lookup(game_state, {Cat, Mouse, Turn}) of
        [] ->
            Result = case Turn rem 2 of
                0 -> 
                    lists:foldl(fun(C) -> 
                        case memo(Moves, C, Mouse, Turn + 1, N) of
                            1 -> 1; 
                            0 -> 0; 
                            _ -> 2 
                        end 
                    end, 2, Moves[Cat]);
                _ -> 
                    lists:foldl(fun(M) -> 
                        case memo(Moves, Cat, M, Turn + 1, N) of
                            2 -> 2; 
                            0 -> 0; 
                            _ -> 1 
                        end 
                    end, 1, Moves[Mouse])
            end,
            ets:insert(game_state, {{Cat, Mouse, Turn}, Result}),
            Result;
        [{_, Result}] -> Result
    end.