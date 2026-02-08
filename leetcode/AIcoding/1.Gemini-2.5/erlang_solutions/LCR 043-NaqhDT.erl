-module(solution).
-export([init/1, insert/2, get_root/1]).

-record(treenode, {val, left = nil, right = nil}).

init(Root) ->
    tree_to_list(Root).

insert(Val, CurrentState) ->
    NewState = CurrentState ++ [Val],
    ParentIdx = floor((length(CurrentState) - 1) / 2),
    ParentVal = lists:nth(ParentIdx + 1, CurrentState),
    {ParentVal, NewState}.

get_root(StateList) ->
    list_to_tree(StateList).

tree_to_list(nil) -> [];
tree_to_list(Root) ->
    Queue = [Root],
    tree_to_list_bfs(Queue, []).

tree_to_list_bfs([], Acc) -> lists:reverse(Acc);
tree_to_list_bfs([#treenode{val = V, left = L, right = R} | RestQueue], Acc) ->
    NewQueue = RestQueue ++ lists:filter(fun(N) -> N /= nil end, [L, R]),
    tree_to_list_bfs(NewQueue, [V | Acc]).

list_to_tree(List) ->
    case List of
        [] -> nil;
        _ ->
            Tuple = list_to_tuple(List),
            list_to_tree_from_tuple(Tuple, 0, length(List))
    end.

list_to_tree_from_tuple(_Tuple, Idx, MaxLen) when Idx >= MaxLen -> nil;
list_to_tree_from_tuple(Tuple, Idx, MaxLen) ->
    Val = element(Idx + 1, Tuple),
    LeftChildIdx = 2 * Idx + 1,
    RightChildIdx = 2 * Idx + 2,
    #treenode{
        val = Val,
        left = list_to_tree_from_tuple(Tuple, LeftChildIdx, MaxLen),
        right = list_to_tree_from_tuple(Tuple, RightChildIdx, MaxLen)
    }.