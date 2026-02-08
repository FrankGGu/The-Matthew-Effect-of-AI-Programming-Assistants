-module(solution).
-export([catMouseGame/1]).

catMouseGame(Board) ->
    N = length(Board),
    cats = lists:seq(1, N),
    mice = lists:seq(1, N),
    State = lists:map(fun(_) -> 0 end, cats ++ mice ++ [0]),
    catMouseGame(State, cats, mice, 0, 0).

catMouseGame(State, Cats, Mice, Turn, Mouse) ->
    if
        Mouse == 0 -> 1;
        lists:any(fun(Cat) -> StateCatMouse(State, Cat, Mouse) end, Cats) -> 0;
        true -> 2
    end.

StateCatMouse(State, Cat, Mouse) ->
    NextState = lists:map(fun(X) -> X + 1 end, State),
    case NextState of
        [H | _] when H == 0 -> true;
        _ -> false
    end.