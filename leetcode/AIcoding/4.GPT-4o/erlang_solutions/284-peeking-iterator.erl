%% Define PeekingIterator
%% -record(peeking_iterator, {iterator, next_elem = undefined, has_peeked = false}).

-spec new_iterator(Iterator :: iterator()) -> #peeking_iterator{}.
new_iterator(Iterator) ->
    #peeking_iterator{iterator = Iterator}.

-spec peek(Iterator :: #peeking_iterator{}) -> integer().
peek(#peeking_iterator{next_elem = NextElem, has_peeked = true}) -> 
    NextElem;
peek(#peeking_iterator{iterator = Iter}) ->
    case Iter:hasNext() of
        true ->
            NextElem = Iter:next(),
            #peeking_iterator{next_elem = NextElem, has_peeked = true};
        false -> 
            undefined
    end.

-spec next(Iterator :: #peeking_iterator{}) -> integer().
next(#peeking_iterator{next_elem = NextElem, has_peeked = true} = Iter) ->
    #peeking_iterator{Iter | next_elem = undefined, has_peeked = false},
    NextElem;
next(#peeking_iterator{iterator = Iter}) ->
    case Iter:hasNext() of
        true -> 
            NextElem = Iter:next(),
            NextElem;
        false -> 
            undefined
    end.

-spec hasNext(Iterator :: #peeking_iterator{}) -> boolean().
hasNext(#peeking_iterator{iterator = Iter}) ->
    Iter:hasNext().
