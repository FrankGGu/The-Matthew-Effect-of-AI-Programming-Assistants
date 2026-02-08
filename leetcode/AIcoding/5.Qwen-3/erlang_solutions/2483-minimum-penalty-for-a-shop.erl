-module(min_penalty).
-export([bestClosingTime/1]).

bestClosingTime(Shops) ->
    N = length(Shops),
    Y = lists:seq(0, N),
    Penalty = lists:map(fun(I) -> 
        Count = lists:foldl(fun({C, _}, Acc) -> 
            if C == $Y -> Acc + 1;
               C == $N -> Acc + 1;
               true -> Acc
            end
        end, 0, lists:sublist(Shops, I)),
        Count
    end, Y),
    lists:foldl(fun({I, P}, {MinI, MinP}) ->
        if P < MinP -> {I, P};
           true -> {MinI, MinP}
        end
    end, {0, hd(Penalty)}, lists:zip(Y, Penalty)).

bestClosingTime(_) -> {0, 0}.