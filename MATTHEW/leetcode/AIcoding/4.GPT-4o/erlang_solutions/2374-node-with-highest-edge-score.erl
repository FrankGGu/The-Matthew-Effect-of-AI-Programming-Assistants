-module(solution).
-export([highest_edge_score/1]).

highest_edge_score/1 ->
    {ok, Input} = io:get_line(""),
    Edges = string:tokens(Input, ","),
    Scores = lists:foldl(fun(_, Acc) -> [0 | Acc] end, [], Edges),
    MaxScore = lists:max(lists:map(fun(X) -> lists:nth(X+1, Scores) + X end, lists:seq(0, length(Edges)-1))),
    lists:foldl(fun({Score, Index}, Acc) -> 
        if 
            Score == MaxScore -> 
                [Index | Acc]; 
            true -> 
                Acc 
        end 
    end, [], lists:zip(Scores, lists:seq(0, length(Scores)-1))).