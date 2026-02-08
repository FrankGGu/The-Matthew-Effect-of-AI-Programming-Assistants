-module(solution).
-export([find_lex_smallest_string/3]).

find_lex_smallest_string(S, A, B) ->
    N = length(S),
    Visited = sets:new(),
    Queue = queue:from_list([S]),
    Min = S,
    bfs(Queue, Visited, Min, A, B, N).

bfs(Queue, Visited, Min, A, B, N) ->
    case queue:is_empty(Queue) of
        true -> Min;
        false ->
            {{value, Current}, NewQueue} = queue:out(Queue),
            case sets:is_element(Current, Visited) of
                true -> bfs(NewQueue, Visited, Min, A, B, N);
                false ->
                    NewVisited = sets:add_element(Current, Visited),
                    NewMin = if Current < Min -> Current; true -> Min end,
                    AddStr = add_op(Current, A, N),
                    RotateStr = rotate_op(Current, B, N),
                    UpdatedQueue = queue:in(AddStr, queue:in(RotateStr, NewQueue)),
                    bfs(UpdatedQueue, NewVisited, NewMin, A, B, N)
            end
    end.

add_op(S, A, N) ->
    List = [list_to_integer([C]) || C <- S],
    AddList = lists:map(fun(X) -> (X + A) rem 10 end, lists:sublist(List, 2, N)),
    NewList = lists:sublist(List, 1, 1) ++ AddList,
    lists:flatten([integer_to_list(X) || X <- NewList]).

rotate_op(S, B, N) ->
    Rotated = lists:sublist(S, N - B + 1, B) ++ lists:sublist(S, 1, N - B),
    Rotated.