-module(stack_using_queues).
-export([new/0, push/2, pop/1, top/1, empty/1]).

new() ->
    {queue:new(), queue:new()}.

push({Q1, Q2}, X) ->
    {queue:in(X, Q1), Q2}.

pop({Q1, Q2}) ->
    case queue:len(Q1) of
        0 ->
            {undefined, {Q1, Q2}};
        1 ->
            {{queue:out(Q1), _}, {queue:new(), Q2}};
        _ ->
            {Q11, Q22} = move_elements(Q1, Q2),
            {{queue:out(Q22), _}, {Q11, queue:new()}}
    end.

top({Q1, Q2}) ->
    case queue:len(Q1) of
        0 ->
            undefined;
        1 ->
            {_, X} = queue:peek(Q1),
            X;
        _ ->
            {Q11, Q22} = move_elements(Q1, Q2),
            {_, X} = queue:peek(Q22),
            {Q11, Q222} = move_elements(Q22, Q11),
            {_, X}
    end.

empty({Q1, _}) ->
    queue:is_empty(Q1).

move_elements(Q1, Q2) ->
    Len = queue:len(Q1),
    move_elements_helper(Q1, Q2, Len - 1).

move_elements_helper(Q1, Q2, 0) ->
    {Q1, Q2};
move_elements_helper(Q1, Q2, N) ->
    {{value, V}, Q11} = queue:out(Q1),
    Q22 = queue:in(V, Q2),
    move_elements_helper(Q11, Q22, N - 1).