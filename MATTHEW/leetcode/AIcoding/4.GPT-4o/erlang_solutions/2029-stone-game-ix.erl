-module(solution).
-export([stone_game_ix/1]).

stone_game_ix(Stones) ->
    Sum = lists:sum(Stones),
    R = Sum rem 3,
    Counts = lists:foldl(fun(X, Acc) -> 
                               case X rem 3 of 
                                   0 -> {element(1, Acc), element(2, Acc) + 1}; 
                                   1 -> {element(1, Acc) + 1, element(2, Acc)}; 
                                   2 -> {element(1, Acc), element(2, Acc) + 1} 
                               end 
                           end, {0, 0}, Stones),
    case R of
        0 -> 
            if 
                element(1, Counts) > 0 -> true; 
                true -> false 
            end;
        1 -> 
            if 
                element(2, Counts) > 0 -> true; 
                true -> false 
            end;
        2 -> 
            if 
                element(1, Counts) > 0 -> true; 
                true -> false 
            end
    end.