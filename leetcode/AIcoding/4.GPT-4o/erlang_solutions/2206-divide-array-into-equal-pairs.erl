-module(solution).
-export([can_divide/1]).

can_divide(List) ->
    Count = length(List),
    if
        Count rem 2 =:= 0 ->
            Pairs = lists:foldl(fun(X, Acc) -> [X | Acc] end, [], List),
            lists:all(fun(X) -> lists:member(X, Pairs) end, lists:sublist(Pairs, 0, Count div 2));
        true ->
            false
    end.