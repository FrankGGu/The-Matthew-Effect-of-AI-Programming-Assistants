-module(front_middle_back_queue).
-export([new/0, push_front/2, push_middle/2, push_back/2, pop_front/1, pop_middle/1, pop_back/1]).

-record(queue, {front = [], middle = [], back = []}).

new() ->
    #queue{}.

push_front(X, Queue) ->
    Queue#queue{front = [X | Queue#queue.front], middle = Queue#queue.middle, back = Queue#queue.back}.

push_middle(X, Queue) ->
    case Queue#queue.middle of
        [] ->
            Queue#queue{front = Queue#queue.front, middle = [X], back = Queue#queue.back};
        _ ->
            Queue#queue{front = Queue#queue.front, middle = [X | Queue#queue.middle], back = Queue#queue.back}
    end.

push_back(X, Queue) ->
    Queue#queue{front = Queue#queue.front, middle = Queue#queue.middle, back = [X | Queue#queue.back]}.

pop_front(Queue) ->
    case Queue#queue.front of
        [] ->
            case Queue#queue.middle of
                [] ->
                    case Queue#queue.back of
                        [] -> {error, Queue};
                        [B | Back] -> {B, Queue#queue{front = [], middle = [], back = Back}}
                    end;
                [M | Middle] ->
                    {M, Queue#queue{front = Middle, middle = [], back = Queue#queue.back}}
            end;
        [F | Front] ->
            {F, Queue#queue{front = Front, middle = Queue#queue.middle, back = Queue#queue.back}}
    end.

pop_middle(Queue) ->
    case Queue#queue.middle of
        [] ->
            case Queue#queue.front of
                [] -> {error, Queue};
                [F | Front] ->
                    case Queue#queue.back of
                        [] -> {F, Queue#queue{front = Front, middle = [], back = []}};
                        [B | Back] -> {B, Queue#queue{front = Front, middle = [], back = Back}}
                    end
            end;
        [M | Middle] ->
            {M, Queue#queue{front = Queue#queue.front, middle = Middle, back = Queue#queue.back}}
    end.

pop_back(Queue) ->
    case Queue#queue.back of
        [] ->
            case Queue#queue.middle of
                [] -> {error, Queue};
                [M | Middle] ->
                    case Queue#queue.front of
                        [] -> {M, Queue#queue{front = [], middle = Middle, back = []}};
                        [F | Front] -> {F, Queue#queue{front = Front, middle = Middle, back = []}}
                    end
            end;
        [B | Back] ->
            {B, Queue#queue{front = Queue#queue.front, middle = Queue#queue.middle, back = Back}}
    end.