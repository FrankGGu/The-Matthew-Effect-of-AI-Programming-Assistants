-module(nested_iterator).
-export([init/1, next/1, has_next/1]).

-record(nested_int, {integer, list}).

init(NestedList) ->
    {ok, lists:reverse(flatten(NestedList))}.

flatten(List) ->
    flatten(List, []).

flatten([], Acc) ->
    Acc;
flatten([H|T], Acc) ->
    case is_list(H) of
        true -> flatten(T, flatten(H, Acc));
        false -> flatten(T, [H|Acc])
    end.

next(Stack) ->
    [H|T] = Stack,
    {H, T}.

has_next(Stack) ->
    Stack =/= [].