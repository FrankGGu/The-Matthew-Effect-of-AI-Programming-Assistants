-module(skiplist).
-export([new/0, search/2, add/2, erase/2]).

-record(node, {val, next}).

new() ->
    #node{val = -infinity, next = []}.

search(Head, Target) ->
    search(Head, Target, 0).

search(#node{next = Nexts}, Target, Level) ->
    case Nexts of
        [] ->
            false;
        _ ->
            Next = lists:nth(Level + 1, Nexts),
            if
                Next == undefined ->
                    false;
                true ->
                    case Next#node.val of
                        Val when Val < Target ->
                            search(Next, Target, Level);
                        Val when Val == Target ->
                            true;
                        _ ->
                            search(Head, Target, Level + 1)
                    end
            end
    end.

add(Head, Val) ->
    add(Head, Val, 0, []).

add(#node{next = Nexts}, Val, Level, Path) ->
    case Nexts of
        [] ->
            NewNode = #node{val = Val, next = lists:duplicate(Level + 1, undefined)},
            lists:foldl(fun(P, Acc) -> set_next(P, Level, NewNode) end, Head, Path),
            ok;
        _ ->
            Next = lists:nth(Level + 1, Nexts),
            if
                Next == undefined ->
                    NewNode = #node{val = Val, next = lists:duplicate(Level + 1, undefined)},
                    lists:foldl(fun(P, Acc) -> set_next(P, Level, NewNode) end, Head, Path),
                    ok;
                true ->
                    case Next#node.val of
                        Val when Val < Val ->
                            add(Next, Val, Level, [Head | Path]);
                        _ ->
                            add(Head, Val, Level + 1, Path)
                    end
            end
    end.

erase(Head, Val) ->
    erase(Head, Val, 0, []).

erase(#node{next = Nexts}, Val, Level, Path) ->
    case Nexts of
        [] ->
            ok;
        _ ->
            Next = lists:nth(Level + 1, Nexts),
            if
                Next == undefined ->
                    ok;
                true ->
                    case Next#node.val of
                        Val ->
                            lists:foldl(fun(P, Acc) -> set_next(P, Level, lists:nth(Level + 1, P#node.next)) end, Head, Path),
                            ok;
                        _ ->
                            erase(Next, Val, Level, [Head | Path])
                    end
            end
    end.

set_next(Node, Level, NewNode) ->
    Nexts = Node#node.next,
    NewNexts = lists:substitute(Level + 1, NewNode, Nexts),
    Node#node{next = NewNexts}.