-module(min_stack).
-export([init/0, push/2, pop/1, top/1, getMin/1]).

init() ->
    {[], []}.

push({Stack, MinStack}, Val) ->
    NewMinStack = case MinStack of
        [] -> [Val];
        [M | _] when Val =< M -> [Val | MinStack];
        _ -> MinStack
    end,
    {[Val | Stack], NewMinStack}.

pop({[H | T], MinStack}) ->
    NewMinStack = case MinStack of
        [M | Rest] when H == M -> Rest;
        _ -> MinStack
    end,
    {T, NewMinStack}.

top({[H | _], _}) ->
    H.

getMin({_, [M | _]}) ->
    M.