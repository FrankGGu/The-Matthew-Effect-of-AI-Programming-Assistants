-module(constrained_subsequence_sum).
-export([max_constrained_sum/2]).

max_constrained_sum(Nums, K) ->
    max_constrained_sum(Nums, K, []).

max_constrained_sum([], _, _) ->
    -1000000000;
max_constrained_sum([H|T], K, Queue) ->
    NewQueue = lists:filter(fun({_, Index}) -> Index >= 0 end, [{H, 0} || _ <- [1]]),
    NewQueue2 = lists:foldl(fun({Val, Index}, Acc) -> 
                                  NewVal = max(Val, H),
                                  [{NewVal, Index+1}|Acc]
                              end, Queue, Queue),
    NewQueue3 = lists:sort(fun({V1, _}, {V2, _}) -> V1 > V2 end, NewQueue2),
    NewQueue4 = NewQueue ++ NewQueue3,
    NewQueue5 = lists:sublist(NewQueue4, K),
    NewQueue6 = lists:sort(fun({V1, _}, {V2, _}) -> V1 > V2 end, NewQueue5),

    case NewQueue6 of
        [] ->
            max(H, max_constrained_sum(T, K, []) );
        [{MaxVal, _} | _] ->
            max(MaxVal, max(H, max_constrained_sum(T, K, NewQueue6)) )
    end.