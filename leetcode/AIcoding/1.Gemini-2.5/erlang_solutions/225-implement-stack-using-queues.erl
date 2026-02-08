-module(my_stack).

-export([new/0, push/2, pop/1, top/1, empty/1]).

new() ->
    {[], []}.

push(Stack, X) ->
    Size = q_size(Stack),
    Q1 = q_enqueue(Stack, X),
    push_reorder(Q1, Size).

pop(Stack) ->
    {Element, NewStack} = q_dequeue(Stack),
    {Element, NewStack}.

top(Stack) ->
    q_peek(Stack).

empty(Stack) ->
    q_is_empty(Stack).

q_enqueue({F, B}, E) ->
    {F, [E|B]}.

q_dequeue({[], []}) ->
    error(badarg, [empty_queue_dequeue]);
q_dequeue({[H|T], B}) ->
    {H, {T, B}};
q_dequeue({[], B}) ->
    q_dequeue({lists:reverse(B), []}).

q_peek({[], []}) ->
    error(badarg, [empty_queue_peek]);
q_peek({[H|_], _}) ->
    H;
q_peek({[], B}) ->
    q_peek({lists:reverse(B), []}).

q_size({F, B}) ->
    length(F) + length(B).

q_is_empty({[], []}) ->
    true;
q_is_empty(_) ->
    false.

push_reorder(Q, 0) ->
    Q;
push_reorder(Q, N) ->
    {E, Q_deq} = q_dequeue(Q),
    Q_enq = q_enqueue(Q_deq, E),
    push_reorder(Q_enq, N - 1).