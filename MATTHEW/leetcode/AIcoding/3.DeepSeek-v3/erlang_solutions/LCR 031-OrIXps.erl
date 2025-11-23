-module(lru_cache).
-export([init/1, get/2, put/3]).

-record(node, {key, val, prev, next}).

init(Capacity) ->
    {#{}, #{}, Capacity, #node{next = nil}, #node{prev = nil}}.

get(Key, {Map, Nodes, Cap, Head, Tail}) ->
    case maps:get(Key, Map, undefined) of
        undefined -> {-1, {Map, Nodes, Cap, Head, Tail}};
        Node ->
            #node{prev = Prev, next = Next} = Node,
            NewNodes = case Prev of
                nil -> Nodes;
                _ ->
                    #node{prev = PrevPrev} = Prev,
                    #node{next = NextNext} = Next,
                    NewPrev = Prev#node{next = Next},
                    NewNext = Next#node{prev = Prev},
                    NewNodes1 = maps:put(PrevPrev#node.key, PrevPrev#node{next = Next}, Nodes),
                    NewNodes2 = maps:put(NextNext#node.key, NextNext#node{prev = Prev}, NewNodes1),
                    maps:put(Key, Node#node{prev = nil, next = Head#node.next}, NewNodes2)
            end,
            NewHead = Head#node{next = Key},
            NewNode = Node#node{prev = nil, next = Head#node.next},
            NewMap = maps:put(Key, NewNode, Map),
            {Node#node.val, {NewMap, NewNodes, Cap, NewHead, Tail}}
    end.

put(Key, Value, {Map, Nodes, Cap, Head, Tail}) ->
    case get(Key, {Map, Nodes, Cap, Head, Tail}) of
        {-1, {Map1, Nodes1, Cap1, Head1, Tail1}} ->
            NewNode = #node{key = Key, val = Value, prev = nil, next = Head1#node.next},
            NewMap = maps:put(Key, NewNode, Map1),
            NewNodes = maps:put(Key, NewNode, Nodes1),
            NewHead = Head1#node{next = Key},
            case maps:size(NewMap) > Cap1 of
                true ->
                    #node{prev = LastPrev} = Tail1,
                    LastKey = LastPrev#node.key,
                    #node{prev = LastLastPrev} = LastPrev,
                    NewTail = Tail1#node{prev = LastLastPrev},
                    NewNodes1 = maps:remove(LastKey, NewNodes),
                    NewMap1 = maps:remove(LastKey, NewMap),
                    {NewMap1, NewNodes1, Cap1, NewHead, NewTail};
                false ->
                    {NewMap, NewNodes, Cap1, NewHead, Tail1}
            end;
        {_, {Map1, Nodes1, Cap1, Head1, Tail1}} ->
            #node{next = Next} = maps:get(Key, Map1),
            NewNode = #node{key = Key, val = Value, prev = nil, next = Next},
            NewMap = maps:put(Key, NewNode, Map1),
            NewNodes = maps:put(Key, NewNode, Nodes1),
            NewHead = Head1#node{next = Key},
            {NewMap, NewNodes, Cap1, NewHead, Tail1}
    end.