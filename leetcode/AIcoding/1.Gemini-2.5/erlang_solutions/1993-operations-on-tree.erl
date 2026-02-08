-module(tree_lock).
-export([new/1, lock/3, unlock/3, upgrade/3]).

-record(state, {
    n :: integer(),
    parent_arr :: array:array(integer()),
    children_arr :: array:array(list(integer())),
    locked_by_arr :: array:array(none | integer()) % user_id or none
}).

new(ParentList) ->
    N = length(ParentList),
    ParentArr = array:from_list(ParentList),

    ChildrenArr = array:new(N, []),
    ChildrenArr1 = build_children_array(0, N, ParentArr, ChildrenArr),

    LockedByArr = array:new(N, none),

    #state{n=N, parent_arr=ParentArr, children_arr=ChildrenArr1, locked_by_arr=LockedByArr}.

build_children_array(I, N, ParentArr, ChildrenArr) when I < N ->
    ParentNode = array:get(I, ParentArr),
    case ParentNode of
        -1 -> build_children_array(I+1, N, ParentArr, ChildrenArr);
        _ ->
            CurrentChildren = array:get(ParentNode, ChildrenArr),
            NewChildrenArr = array:set(ParentNode, [I | CurrentChildren], ChildrenArr),
            build_children_array(I+1, N, ParentArr, NewChildrenArr)
    end;
build_children_array(_I, _N, _ParentArr, ChildrenArr) ->
    ChildrenArr.

lock(Node, User, State) ->
    #state{locked_by_arr=LockedByArr} = State,
    case array:get(Node, LockedByArr) of
        none ->
            case has_locked_descendants(Node, State) of
                true -> {false, State};
                false ->
                    NewLockedByArr = array:set(Node, User, LockedByArr),
                    {true, State#state{locked_by_arr=NewLockedByArr}}
            end;
        _ -> {false, State}
    end.

unlock(Node, User, State) ->
    #state{locked_by_arr=LockedByArr} = State,
    case array:get(Node, LockedByArr) of
        User ->
            NewLockedByArr = array:set(Node, none, LockedByArr),
            {true, State#state{locked_by_arr=NewLockedByArr}};
        _ -> {false, State}
    end.

upgrade(Node, User, State) ->
    #state{locked_by_arr=LockedByArr} = State,
    case array:get(Node, LockedByArr) of
        none ->
            LockedDescendants = get_locked_descendants(Node, State),
            case length(LockedDescendants) of
                0 -> {false, State};
                _ ->
                    case is_ancestor_locked(Node, State) of
                        true -> {false, State};
                        false ->
                            case lists:all(fun({_, U}) -> U == User end, LockedDescendants) of
                                false -> {false, State};
                                true ->
                                    NewLockedByArr1 = array:set(Node, User, LockedByArr),
                                    NewLockedByArr2 = lists:foldl(fun({D, _}, AccArr) ->
                                                                      array:set(D, none, AccArr)
                                                                  end, NewLockedByArr1, LockedDescendants),
                                    {true, State#state{locked_by_arr=NewLockedByArr2}}
                            end
                    end
            end;
        _ -> {false, State}
    end.

is_ancestor_locked(Node, #state{parent_arr=ParentArr, locked_by_arr=LockedByArr}) ->
    is_ancestor_locked_loop(Node, ParentArr, LockedByArr).

is_ancestor_locked_loop(Node, ParentArr, LockedByArr) ->
    case array:get(Node, ParentArr) of
        -1 -> false;
        ParentNode ->
            case array:get(ParentNode, LockedByArr) of
                none -> is_ancestor_locked_loop(ParentNode, ParentArr, LockedByArr);
                _ -> true
            end
    end.

has_locked_descendants(Node, State) ->
    #state{children_arr=ChildrenArr, locked_by_arr=LockedByArr} = State,
    Queue = {array:get(Node, ChildrenArr), []},
    has_locked_descendants_bfs(Queue, ChildrenArr, LockedByArr).

has_locked_descendants_bfs({[], []}, _ChildrenArr, _LockedByArr) ->
    false;
has_locked_descendants_bfs({[], OutQ}, ChildrenArr, LockedByArr) ->
    has_locked_descendants_bfs({lists:reverse(OutQ), []}, ChildrenArr, LockedByArr);
has_locked_descendants_bfs({[H|InQ], OutQ}, ChildrenArr, LockedByArr) ->
    case array:get(H, LockedByArr) of
        none ->
            ChildrenOfH = array:get(H, ChildrenArr),
            has_locked_descendants_bfs({InQ, ChildrenOfH ++ OutQ}, ChildrenArr, LockedByArr);
        _ -> true
    end.

get_locked_descendants(Node, State) ->
    #state{children_arr=ChildrenArr, locked_by_arr=LockedByArr} = State,
    Queue = {array:get(Node, ChildrenArr), []},
    get_locked_descendants_bfs(Queue, ChildrenArr, LockedByArr, []).

get_locked_descendants_bfs({[], []}, _ChildrenArr, _LockedByArr, Acc) ->
    Acc;
get_locked_descendants_bfs({[], OutQ}, ChildrenArr, LockedByArr, Acc) ->
    get_locked_descendants_bfs({lists:reverse(OutQ), []}, ChildrenArr, LockedByArr, Acc);
get_locked_descendants_bfs({[H|InQ], OutQ}, ChildrenArr, LockedByArr, Acc) ->
    NewAcc = case array:get(H, LockedByArr) of
                 none -> Acc;
                 User -> [{H, User} | Acc]
             end,
    ChildrenOfH = array:get(H, ChildrenArr),
    get_locked_descendants_bfs({InQ, ChildrenOfH ++ OutQ}, ChildrenArr, LockedByArr, NewAcc).