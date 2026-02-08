-module(solution).
-export([find_lex_smallest_string/3]).

find_lex_smallest_string(S, A, B) ->
    N = length(S),
    Visited = sets:new(),
    Queue = queue:from_list([S]),
    MinStr = S,
    bfs(Queue, Visited, MinStr, N, A, B).

bfs(Queue, Visited, MinStr, N, A, B) ->
    case queue:is_empty(Queue) of
        true -> MinStr;
        false ->
            {{value, Current}, Q1} = queue:out(Queue),
            case sets:is_element(Current, Visited) of
                true -> bfs(Q1, Visited, MinStr, N, A, B);
                false ->
                    NewVisited = sets:add_element(Current, Visited),
                    NewMinStr = if Current < MinStr -> Current; true -> MinStr end,
                    Op1 = add_op(Current, A),
                    Op2 = rotate_op(Current, B),
                    Q2 = queue:in(Op1, Q1),
                    Q3 = queue:in(Op2, Q2),
                    bfs(Q3, NewVisited, NewMinStr, N, A, B)
            end
    end.

add_op(S, A) ->
    list_to_binary([ [(X - $0 + A) rem 10 + $0 || X <- binary_to_list(S)] ]).

rotate_op(S, B) ->
    N = size(S),
    B1 = B rem N,
    <<Prefix:B1/binary, Suffix/binary>> = S,
    <<Suffix/binary, Prefix/binary>>.