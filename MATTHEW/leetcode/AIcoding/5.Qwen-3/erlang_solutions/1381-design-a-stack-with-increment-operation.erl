-module(stack_with_increment).
-export([new/0, push/2, pop/1, increment/2]).

new() ->
    [].

push(Stack, Val) ->
    [Val | Stack].

pop(Stack) ->
    [H | T] = Stack,
    {H, T}.

increment(Stack, K) ->
    increment(Stack, K, []).

increment([], _K, Acc) ->
    lists:reverse(Acc);
increment([H | T], K, Acc) ->
    increment(T, K, [H + K | Acc]).