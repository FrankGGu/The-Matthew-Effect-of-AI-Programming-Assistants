-module(linked_list_random_node).
-export([new/1, get_random/1]).

-record(node, {val, next}).

new(Values) ->
    lists:foldr(fun(V, Acc) -> #node{val = V, next = Acc} end, nil, Values).

get_random(Node) ->
    get_random(Node, 1, Node).

get_random(nil, _, _) ->
    error(badarg);
get_random(Node, K, Result) ->
    Random = rand:uniform(K),
    if
        Random == 1 ->
            Node;
        true ->
            get_random(Node#node.next, K + 1, Result)
    end.