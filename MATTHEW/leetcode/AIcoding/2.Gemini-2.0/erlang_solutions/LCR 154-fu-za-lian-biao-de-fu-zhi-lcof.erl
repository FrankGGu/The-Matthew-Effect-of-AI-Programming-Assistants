-module(copyRandomList).
-export([copyRandomList/1]).

-record(node, {val, next, random}).

copyRandomList(Head) ->
  copyRandomList_helper(Head, {}).

copyRandomList_helper(null, Map) ->
  null;
copyRandomList_helper(Node, Map) ->
  case maps:is_key(Node, Map) of
    true ->
      maps:get(Node, Map);
    false ->
      Val = Node#node.val,
      NewNode = #node{val = Val, next = null, random = null},
      NewMap = maps:put(Node, NewNode, Map),
      Next = Node#node.next,
      Random = Node#node.random,
      NewNext = copyRandomList_helper(Next, NewMap),
      NewRandom = 
        case Random of
          null -> null;
          _ -> 
            case maps:is_key(Random, NewMap) of
              true ->
                maps:get(Random, NewMap);
              false ->
                RandomVal = Random#node.val,
                NewRandomNode = #node{val = RandomVal, next = null, random = null},
                NewNewMap = maps:put(Random, NewRandomNode, NewMap),
                NewRandomNode
            end
        end,
      NewNode#node{next = NewNext, random = NewRandom}
  end.