-module(peeking_iterator).
-export([init/1, peek/1, next/1, has_next/1]).

-record(peeking_iterator, {iterator, next_val, has_next}).

init(Iterator) ->
    HasNext = Iterator:has_next(),
    if
        HasNext ->
            NextVal = Iterator:next(),
            #peeking_iterator{iterator=Iterator, next_val=NextVal, has_next=true};
        true ->
            #peeking_iterator{iterator=Iterator, next_val=undefined, has_next=false}
    end.

peek(#peeking_iterator{next_val=NextVal}) ->
    NextVal.

next(#peeking_iterator{iterator=Iterator, next_val=NextVal, has_next=HasNext}=State) ->
    if
        HasNext ->
            NewHasNext = Iterator:has_next(),
            if
                NewHasNext ->
                    NewNextVal = Iterator:next(),
                    {NextVal, State#peeking_iterator{next_val=NewNextVal, has_next=true}};
                true ->
                    {NextVal, State#peeking_iterator{next_val=undefined, has_next=false}}
            end;
        true ->
            {undefined, State}
    end.

has_next(#peeking_iterator{has_next=HasNext}) ->
    HasNext.