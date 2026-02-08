-module(min_stack).
-export([new/0, push/2, pop/1, top/1, getMin/1]).

new() ->
    {[], []}.

push({Stack, MinStack}, X) ->
    NewMinStack = case MinStack of
        [] -> [X];
        [H|_] -> if X =< H then [X|MinStack] else MinStack end
    end,
    {[X|Stack], NewMinStack}.

pop({Stack, MinStack}) ->
    case Stack of
        [] -> {Stack, MinStack};
        [H|Rest] ->
            NewMinStack = case MinStack of
                [] -> [];
                [MH|MRest] -> if H == MH then MRest else MinStack end
            end,
            {Rest, NewMinStack}
    end.

top({Stack, _}) ->
    case Stack of
        [] -> null;
        [H|_] -> H
    end.

getMin({_, MinStack}) ->
    case MinStack of
        [] -> null;
        [H|_] -> H
    end.