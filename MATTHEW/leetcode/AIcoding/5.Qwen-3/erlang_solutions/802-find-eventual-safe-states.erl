-module(safe_states).
-export([eventualSafeStates/1]).

eventualSafeStates(Graph) ->
    N = length(Graph),
    State = array:new(N, {default, 0}),
    Visited = array:new(N, {default, false}),
    Result = array:new(N, {default, false}),
    lists:foreach(fun(I) -> check(I, Graph, State, Visited, Result) end, lists:seq(0, N-1)),
    lists:filter(fun(I) -> array:get(I, Result) == true end, lists:seq(0, N-1)).

check(Node, Graph, State, Visited, Result) ->
    case array:get(Node, Visited) of
        true ->
            case array:get(Node, State) of
                1 -> ok;
                _ -> array:set(Node, 2, State)
            end;
        false ->
            array:set(Node, true, Visited),
            array:set(Node, 1, State),
            Children = lists:nth(Node+1, Graph),
            case lists:all(fun(C) -> check(C, Graph, State, Visited, Result) == ok end, Children) of
                true ->
                    array:set(Node, 2, State),
                    array:set(Node, true, Result);
                false ->
                    ok
            end,
            array:set(Node, false, Visited)
    end.