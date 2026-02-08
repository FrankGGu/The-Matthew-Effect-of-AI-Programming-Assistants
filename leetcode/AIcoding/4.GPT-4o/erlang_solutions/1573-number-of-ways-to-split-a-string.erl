-module(solution).
-export([num_ways/1]).

num_ways(S) ->
    N = string:length(S),
    {Count, _} = lists:foldl(fun(C, {Count, Acc}) ->
        case C of
            $0 -> {Count, Acc + 1};
            $1 -> {Count + Acc, Acc}
        end
    end, {0, 0}, string:to_list(S)),
    if 
        Count == 0 -> 1;
        Count > 0 -> (Count + 1) rem 1000000007
    end.