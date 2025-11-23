-module(all_one).
-export([new/0, inc/2, dec/2, get_max_key/1, get_min_key/1]).

-record(node, {key, count, prev, next}).

new() ->
    #{
        head => #node{next = tail},
        tail => #node{prev = head},
        key_map => #{},
        count_map => #{}
    }.

inc(Key, State = #{key_map := KeyMap, count_map := CountMap}) ->
    case maps:get(Key, KeyMap, undefined) of
        undefined ->
            NewCount = 1,
            NewKeyMap = maps:put(Key, NewCount, KeyMap),
            NewCountMap = update_count_map(Key, NewCount, CountMap),
            insert_after_head(Key, NewCount, State#{key_map := NewKeyMap, count_map := NewCountMap});
        OldCount ->
            NewCount = OldCount + 1,
            NewKeyMap = maps:put(Key, NewCount, KeyMap),
            NewCountMap = update_count_map(Key, NewCount, CountMap),
            remove_key_from_count_map(Key, OldCount, NewCountMap),
            Node = get_node(Key, OldCount, State),
            remove_node(Node),
            insert_after_count(Key, NewCount, State#{key_map := NewKeyMap, count_map := NewCountMap})
    end.

dec(Key, State = #{key_map := KeyMap, count_map := CountMap}) ->
    case maps:get(Key, KeyMap, undefined) of
        undefined ->
            State;
        OldCount when OldCount =:= 1 ->
            NewKeyMap = maps:remove(Key, KeyMap),
            NewCountMap = remove_key_from_count_map(Key, OldCount, CountMap),
            Node = get_node(Key, OldCount, State),
            remove_node(Node),
            State#{key_map := NewKeyMap, count_map := NewCountMap};
        OldCount ->
            NewCount = OldCount - 1,
            NewKeyMap = maps:put(Key, NewCount, KeyMap),
            NewCountMap = update_count_map(Key, NewCount, CountMap),
            remove_key_from_count_map(Key, OldCount, NewCountMap),
            Node = get_node(Key, OldCount, State),
            remove_node(Node),
            insert_after_count(Key, NewCount, State#{key_map := NewKeyMap, count_map := NewCountMap})
    end.

get_max_key(#{head := #node{next = #node{key = Key, count = _Count}} = State) ->
    case Key of
        tail -> "";
        _ -> Key
    end.

get_min_key(#{tail := #node{prev = #node{key = Key, count = _Count}} = State) ->
    case Key of
        head -> "";
        _ -> Key
    end.

update_count_map(Key, Count, CountMap) ->
    case maps:get(Count, CountMap, undefined) of
        undefined ->
            maps:put(Count, #{Key => true}, CountMap);
        Keys ->
            NewKeys = maps:put(Key, true, Keys),
            maps:put(Count, NewKeys, CountMap)
    end.

remove_key_from_count_map(Key, Count, CountMap) ->
    case maps:get(Count, CountMap, undefined) of
        undefined ->
            CountMap;
        Keys ->
            NewKeys = maps:remove(Key, Keys),
            case maps:size(NewKeys) of
                0 -> maps:remove(Count, CountMap);
                _ -> maps:put(Count, NewKeys, CountMap)
            end
    end.

get_node(Key, Count, #{count_map := CountMap}) ->
    #{Count := Keys} = CountMap,
    #{Key := Node} = Keys,
    Node.

insert_after_head(Key, Count, State = #{head := Head}) ->
    Next = Head#node.next,
    Node = #node{key = Key, count = Count, prev = Head, next = Next},
    Head#node.next = Node,
    Next#node.prev = Node,
    update_count_map_with_node(Key, Count, Node, State).

insert_after_count(Key, Count, State = #{count_map := CountMap}) ->
    case maps:get(Count, CountMap, undefined) of
        undefined ->
            #{Count := #{Key := PrevNode}} = CountMap,
            Next = PrevNode#node.next,
            Node = #node{key = Key, count = Count, prev = PrevNode, next = Next},
            PrevNode#node.next = Node,
            Next#node.prev = Node,
            update_count_map_with_node(Key, Count, Node, State);
        _ ->
            insert_after_head(Key, Count, State)
    end.

update_count_map_with_node(Key, Count, Node, State = #{count_map := CountMap}) ->
    Keys = maps:get(Count, CountMap),
    NewKeys = maps:put(Key, Node, Keys),
    NewCountMap = maps:put(Count, NewKeys, CountMap),
    State#{count_map := NewCountMap}.

remove_node(Node) ->
    Prev = Node#node.prev,
    Next = Node#node.next,
    Prev#node.next = Next,
    Next#node.prev = Prev.