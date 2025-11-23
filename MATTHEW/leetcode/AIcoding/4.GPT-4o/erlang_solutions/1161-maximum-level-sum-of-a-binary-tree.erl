-module(solution).
-export([max_level_sum/1]).

-record(node, {val, left = none, right = none}).

max_level_sum(Root) ->
    max_level_sum(Root, 1, [{0, 0}]). 

max_level_sum(none, _, Sums) ->
    lists:max(fun({Sum, _}) -> Sum end, Sums);
max_level_sum(#node{val = Val, left = Left, right = Right}, Level, Sums) ->
    NewSums = lists:map(fun({Sum, L}) -> 
        if 
            L == Level -> 
                {Sum + Val, L}; 
            true -> 
                {Sum, L} 
        end 
    end, Sums),
    max_level_sum(Left, Level + 1, NewSums),
    max_level_sum(Right, Level + 1, NewSums).