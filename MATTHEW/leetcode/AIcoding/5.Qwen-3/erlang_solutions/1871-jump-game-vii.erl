-module(jump_game_vii).
-export([can_reach/2]).

can_reach(S, a) ->
    N = length(S),
    Max = N - 1,
    Visited = erlang:make_ref(),
    can_reach(S, a, 0, Visited, Max).

can_reach(_, _, I, _, Max) when I > Max -> false;
can_reach(_, _, I, _, Max) when I =:= Max -> true;
can_reach(S, A, I, Visited, Max) ->
    case lists:nth(I + 1, S) of
        $0 ->
            case erlang:is_reference(Visited) of
                true -> false;
                false -> 
                    NewVisited = [I | Visited],
                    Next1 = I + A,
                    Next2 = I - A,
                    case can_reach(S, A, Next1, NewVisited, Max) of
                        true -> true;
                        _ -> can_reach(S, A, Next2, NewVisited, Max)
                    end
            end;
        $1 ->
            case erlang:is_reference(Visited) of
                true -> false;
                false -> 
                    NewVisited = [I | Visited],
                    Next1 = I + A,
                    Next2 = I - A,
                    case can_reach(S, A, Next1, NewVisited, Max) of
                        true -> true;
                        _ -> can_reach(S, A, Next2, NewVisited, Max)
                    end
            end
    end.