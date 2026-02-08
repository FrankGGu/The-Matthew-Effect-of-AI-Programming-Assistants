-module(solution).
-export([openLock/2]).

openLock(Start, Deadends) ->
    openLock(Start, Deadends, #{}, []).

openLock(Start, Deadends, Visited, Queue) when Start == "0000" ->
    0;
openLock(Start, Deadends, Visited, Queue) ->
    case lists:member(Start, Deadends) of
        true -> -1;
        false ->
            NewVisited = maps:put(Start, true, Visited),
            NewQueue = lists:foldl(fun(X, Acc) -> [X | Acc] end, Queue, next_states(Start)),
            bfs(NewQueue, NewVisited, 1, Deadends)
    end.

bfs([], _, _, _) -> -1;
bfs(Queue, Visited, Depth, Deadends) ->
    NewQueue = [],
    NewDepth = Depth + 1,
    lists:foldl(fun(State, Acc) ->
        case lists:member(State, Deadends) of
            true -> Acc;
            false ->
                case State == "0000" of
                    true -> Depth;
                    false ->
                        case maps:is_key(State, Visited) of
                            true -> Acc;
                            false -> [State | Acc]
                        end
                end
        end, NewQueue, Queue) ++
    bfs(NewQueue, Visited, NewDepth, Deadends).

next_states(State) ->
    [next_state(State, I, D) || I <- lists:seq(0, 3), D <- [1, -1]].

next_state(State, Index, Delta) ->
    Ch = list_to_integer(string:substr(State, Index + 1, 1)),
    NewCh = (Ch + Delta + 10) rem 10,
    string:join([string:substr(State, 1, Index), integer_to_list(NewCh), string:substr(State, Index + 2)], "").