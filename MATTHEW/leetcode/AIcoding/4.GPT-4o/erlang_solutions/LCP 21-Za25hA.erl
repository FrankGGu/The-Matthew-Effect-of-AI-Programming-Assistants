-module(solution).
-export([catMouseGame/1]).

catMouseGame(M) ->
    N = length(M),
    memo(0, 1, 2, M, N).

memo(Cat, Mouse, Turn, M, N) ->
    case is_terminal(Cat, Mouse, Turn, N) of
        true -> 
            case Turn of
                0 -> 1; % Mouse wins
                1 -> 2  % Cat wins
            end;
        false ->
            case Turn of
                0 -> best_mouse(Cat, Mouse, Turn, M, N);
                1 -> best_cat(Cat, Mouse, Turn, M, N)
            end
    end.

is_terminal(Cat, Mouse, Turn, N) ->
    Cat == Mouse -> true; 
    Cat == 0 -> true; 
    Mouse == 0 -> true; 
    false.

best_mouse(Cat, Mouse, Turn, M, N) ->
    Lists = lists:seq(1, N),
    Results = lists:map(fun (NextMouse) -> memo(Cat, NextMouse, 1, M, N) end, Lists),
    case lists:any(fun (R) -> R == 1 end, Results) of
        true -> 1;
        false -> 2
    end.

best_cat(Cat, Mouse, Turn, M, N) ->
    Lists = lists:seq(1, N),
    Results = lists:map(fun (NextCat) -> memo(NextCat, Mouse, 0, M, N) end, Lists),
    case lists:any(fun (R) -> R == 2 end, Results) of
        true -> 2;
        false -> 1
    end.