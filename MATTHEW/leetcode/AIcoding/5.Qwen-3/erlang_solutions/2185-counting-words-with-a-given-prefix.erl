-module(solution).
-export([prefix_count/2]).

prefix_count( Words, Prefix ) ->
    lists:foldl( fun(W, Acc) -> 
        case string:prefix(W, Prefix) of
            true -> Acc + 1;
            _ -> Acc
        end
    end, 0, Words).