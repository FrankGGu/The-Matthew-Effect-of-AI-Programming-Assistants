-module(leetcode_flatten_nested_list_iterator).
-export([new/1, next/1, hasNext/1]).

-record(iterator, {stack}).

new(NestedList) ->
    Stack = lists:reverse(NestedList),
    #iterator{stack = Stack}.

next(#iterator{stack = [H | T]}) ->
    H;
next(_) ->
    erlang:error(badarg).

hasNext(#iterator{stack = []}) ->
    false;
hasNext(#iterator{stack = [H | _]}) when is_integer(H) ->
    true;
hasNext(#iterator{stack = [H | T]}) ->
    case is_list(H) of
        true ->
            NewStack = lists:reverse(H) ++ T,
            #iterator{stack = NewStack};
        false ->
            true
    end.