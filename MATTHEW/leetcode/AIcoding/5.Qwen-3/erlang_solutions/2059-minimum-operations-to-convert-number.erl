-module(minimum_operations_to_convert_number).
-export([min_ops/3]).

min_ops(Start, Goal, Max) ->
    bfs([{Start, 0}], dict:new(), Start, Goal, Max).

bfs([], _Visited, _Goal, _Max) ->
    -1;

bfs([{Num, Ops} | Rest], Visited, Goal, Max) ->
    case Num of
        Goal -> Ops;
        _ ->
            case dict:is_key(Num, Visited) of
                true -> bfs(Rest, Visited, Goal, Max);
                false ->
                    NewVisited = dict:store(Num, true, Visited),
                    NextNums = lists:filter(fun(N) -> N >= 0 andalso N =< Max end, [Num + 1, Num - 1, Num * 2]),
                    NewQueue = lists:append(Rest, lists:map(fun(N) -> {N, Ops + 1} end, NextNums)),
                    bfs(NewQueue, NewVisited, Goal, Max)
            end
    end.