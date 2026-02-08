-module(solution).
-export([can_construct/2]).

can_construct(K, S) ->
    Counts = lists:foldl(fun(Char, Acc) -> 
        lists:keystore(Char, 1, Acc, {Char, 0}) + 1 
    end, [], S),
    OddCount = lists:filter(fun({_, Count}) -> Count rem 2 =:= 1 end, Counts),
    case length(OddCount) =< K of
        true -> true;
        false -> false
    end.