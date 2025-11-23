-module(solution).
-export([remove_nth_from_end/2]).

-type list_node() :: {Value, Node} | none.
-type Node() :: {list_node(), list_node()}.

remove_nth_from_end(List, N) ->
    Length = length(List),
    Nth = Length - N,
    remove_at(List, Nth).

remove_at([], _) -> [];
remove_at([_ | Tail], 0) -> Tail;
remove_at([Head | Tail], Index) ->
    [Head | remove_at(Tail, Index - 1)].