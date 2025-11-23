-module(peeking_iterator).
-export([new/1, hasNext/1, next/1, peek/1]).

-define(ITERATOR, iterator).

-record(state, {iterator, cache}).

new(Iterator) ->
    #state{iterator = Iterator, cache = undefined}.

hasNext(#state{iterator = Iterator, cache = Cache}) ->
    case Cache of
        undefined -> erlang:element(2, Iterator);
        _ -> true
    end.

next(#state{iterator = Iterator, cache = Cache} = State) ->
    case Cache of
        undefined ->
            [Value | Rest] = erlang:element(2, Iterator),
            NewState = State#state{iterator = {Rest, Iterator}},
            Value;
        _ ->
            Value = Cache,
            NewState = State#state{cache = undefined},
            Value
    end.

peek(#state{cache = Cache}) ->
    Cache.