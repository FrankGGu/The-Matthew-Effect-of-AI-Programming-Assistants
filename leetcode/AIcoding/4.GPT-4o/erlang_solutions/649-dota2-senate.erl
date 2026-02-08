-module(solution).
-export([dota2Senate/1]).

dota2Senate(S) ->
    Queue = lists:foldl(fun(X, Acc) -> [{X, 1} | Acc] end, [], S),
    iterate(Queue).

iterate(Queue) ->
    case Queue of
        [] -> 
            "";
        _ ->
            {Winner, NewQueue} = select_winner(Queue),
            NextQueue = lists:map(fun({C, R}) -> 
                if C == Winner -> {C, R + 1}; true -> {C, R} end 
            end, NewQueue),
            iterate(lists:filter(fun({_, R}) -> R > 0 end, NextQueue))
    end.

select_winner(Queue) ->
    case lists:foldl(fun({C, R}, {Max, M}) -> 
        if R > Max -> {R, C}; true -> {Max, M} end 
    end, {0, undefined}, Queue) of
        {_, C} -> {C, Queue}
    end.