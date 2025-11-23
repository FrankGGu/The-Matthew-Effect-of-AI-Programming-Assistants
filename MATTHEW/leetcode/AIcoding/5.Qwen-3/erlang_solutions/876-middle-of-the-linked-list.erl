-module(middle_of_the_linked_list).
-export([middle_node/1]).

-record(list_node, {val, next}).

middle_node(#list_node{next = nil}) ->
    nil;
middle_node(Head) ->
    Fast = Head,
    Slow = Head,
    loop(Fast, Slow).

loop(#list_node{next = Next}, #list_node{next = nil}) ->
    Slow;
loop(#list_node{next = FastNext}, #list_node{next = SlowNext}) ->
    loop(FastNext, SlowNext);
loop(#list_node{next = FastNext}, Slow) ->
    loop(FastNext, Slow).