-module(queue_stacks).
-export([new/0, push/2, pop/1, peek/1, empty/1]).

new() -> {[], []}.

push({In, Out}, X) -> {[X|In], Out}.

pop({[], []}) -> undefined;
pop({In, []}) ->
    {Reversed, _} = lists:foldl(fun(E, {Acc, List}) -> {Acc, [E|List]} end, {[], []}, In),
    [H|T] = lists:reverse(Reversed),
    {[], lists:reverse(T)};
pop({In, [H|T]}) -> {In, T}.

peek({[], []}) -> undefined;
peek({In, []}) ->
    {Reversed, _} = lists:foldl(fun(E, {Acc, List}) -> {Acc, [E|List]} end, {[], []}, In),
    [H|_] = lists:reverse(Reversed),
    H;
peek({In, [H|_]}) -> H.

empty({[], []}) -> true;
empty({In, Out}) -> length(In) + length(Out) == 0.