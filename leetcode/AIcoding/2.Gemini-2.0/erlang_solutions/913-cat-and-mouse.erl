-module(cat_and_mouse).
-export([cat_mouse/3]).

cat_mouse(graph, cat, mouse) ->
    cat_mouse(graph, cat, mouse, 0, []).

cat_mouse(_Graph, Cat, Mouse, Moves, Visited) when Cat == Mouse ->
    0;
cat_mouse(_Graph, _Cat, 0, _Moves, _Visited) ->
    1;
cat_mouse(_Graph, _Cat, _Mouse, Moves, _Visited) when Moves > 200 ->
    0; % Draw
cat_mouse(Graph, Cat, Mouse, Moves, Visited) ->
    State = {Cat, Mouse, Moves rem 2},
    case lists:member(State, Visited) of
        true ->
            0; % Draw
        false ->
            cat_mouse_helper(Graph, Cat, Mouse, Moves, [State | Visited])
    end.

cat_mouse_helper(Graph, Cat, Mouse, Moves, Visited) ->
    case Moves rem 2 of
        0 -> % Mouse's turn
            Neighbors = lists:nth(Mouse, Graph),
            Results = [cat_mouse(Graph, Cat, NextMouse, Moves + 1, Visited) || NextMouse <- Neighbors],
            case lists:member(1, Results) of
                true ->
                    1; % Mouse wins
                false ->
                    case lists:all(fun(X) -> X == 0 end, Results) of
                        true ->
                            2; % Cat wins
                        false ->
                            0 % Draw
                    end
            end;
        1 -> % Cat's turn
            Neighbors = lists:nth(Cat, Graph),
            Results = [cat_mouse(Graph, NextCat, Mouse, Moves + 1, Visited) || NextCat <- Neighbors, NextCat /= 0],
            case lists:member(2, Results) of
                true ->
                    2; % Cat wins
                false ->
                    case lists:all(fun(X) -> X == 1 end, Results) of
                        true ->
                            1; % Mouse wins
                        false ->
                            0 % Draw
                    end
            end
    end.