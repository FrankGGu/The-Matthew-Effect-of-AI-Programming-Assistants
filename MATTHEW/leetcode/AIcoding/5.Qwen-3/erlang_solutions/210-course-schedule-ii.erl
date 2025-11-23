-module(course_schedule_ii).
-export([find_order/2]).

find_order(N, Pairs) ->
    Adj = lists:foldl(fun({U, V}, Acc) -> 
        lists:keystore(V, 1, Acc, {V, [U | proplists:get_value(V, Acc, [])]}) 
    end, lists:seq(0, N-1), Pairs),
    InDegree = lists:foldl(fun({U, V}, Acc) -> 
        lists:keystore(U, 1, Acc, {U, proplists:get_value(U, Acc, 0) + 1})
    end, lists:seq(0, N-1), Pairs),
    Queue = lists:filter(fun(X) -> proplists:get_value(X, InDegree, 0) == 0 end, lists:seq(0, N-1)),
    TopoSort([], Queue, Adj, InDegree).

TopoSort(Result, [], _, _) ->
    case length(Result) == N of
        true -> lists:reverse(Result);
        false -> []
    end;
TopoSort(Result, [H | T], Adj, InDegree) ->
    NewResult = [H | Result],
    Neighbors = proplists:get_value(H, Adj, []),
    NewInDegree = lists:foldl(fun(Node, Acc) ->
        lists:keystore(Node, 1, Acc, {Node, proplists:get_value(Node, Acc, 0) - 1})
    end, InDegree, Neighbors),
    NewQueue = lists:foldl(fun(Node, Acc) ->
        case proplists:get_value(Node, NewInDegree, 0) of
            0 -> [Node | Acc];
            _ -> Acc
        end
    end, T, Neighbors),
    TopoSort(NewResult, NewQueue, Adj, NewInDegree).