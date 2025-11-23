-module(odd_even_linked_list).
-export([odd_even_list/1]).

-record(list_node, {val, next}).

odd_even_list(undefined) ->
    undefined;
odd_even_list(#list_node{val=Val, next=Next}) ->
    {OddHead, EvenHead} = split(Next, #list_node{val=Val, next=undefined}, #list_node{val=0, next=undefined}),
    connect(EvenHead, OddHead).

split(undefined, OddTail, EvenTail) ->
    {OddTail, EvenTail};
split(#list_node{val=Val, next=Next}, OddTail, EvenTail) ->
    NewOddTail = #list_node{val=Val, next=OddTail},
    split(Next, NewOddTail, EvenTail);
split(#list_node{val=Val, next=Next}, OddTail, EvenTail) ->
    NewEvenTail = #list_node{val=Val, next=EvenTail},
    split(Next, OddTail, NewEvenTail).

connect(undefined, OddHead) ->
    OddHead;
connect(#list_node{next=EvenNext}, OddHead) ->
    connect(EvenNext, OddHead);
connect(EvenHead, OddHead) ->
    connect(EvenHead#list_node.next, OddHead#list_node{next=EvenHead}).