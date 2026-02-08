-module(solve).
-export([detect_cycle/1]).

-record(list_node, {val, next}).

detect_cycle(undefined) -> undefined;
detect_cycle(Node) ->
    {HasCycle, Intersection} = has_cycle(Node),
    if
        HasCycle ->
            {_, Slow} = find_cycle_start(Node, Intersection);
        true ->
            undefined
    end.

has_cycle(Node) ->
    has_cycle(Node, Node, 0).

has_cycle(Slow, Fast, _Steps) when Fast =:= undefined -> {false, undefined};
has_cycle(Slow, Fast, _Steps) when Fast#list_node.next =:= undefined -> {false, undefined};
has_cycle(Slow, Fast, Steps) ->
    NextSlow = Slow#list_node.next,
    NextFast = Fast#list_node.next#list_node.next,
    case NextSlow of
        NextFast -> {true, NextSlow};
        _ -> has_cycle(NextSlow, NextFast, Steps + 1)
    end.

find_cycle_start(Head, Intersection) ->
    find_cycle_start(Head, Intersection, 0).

find_cycle_start(Head, Intersection, Steps) when Head =:= Intersection -> {Steps, Head};
find_cycle_start(Head, Intersection, Steps) ->
    find_cycle_start(Head#list_node.next, Intersection#list_node.next, Steps + 1).