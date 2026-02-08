-module(solution).
-export([greatest_letter/1]).

greatest_letter(S) ->
    Upper = maps:fold(fun(C, Acc) -> if 
        C >= $A, C =< $Z -> lists:append(Acc, [C]);
        true -> Acc 
    end, [], S),
    Lower = maps:fold(fun(C, Acc) -> if 
        C >= $a, C =< $z -> lists:append(Acc, [C]);
        true -> Acc 
    end, [], S),
    UpperLetters = lists:map(fun(C) -> C end, Upper),
    LowerLetters = lists:map(fun(C) -> C end, Lower),
    lists:foldl(fun(X, Acc) -> if 
        lists:member(lists:nth(1, string:to_lower(X)), LowerLetters) -> 
            lists:max([X | Acc]); 
        true -> Acc 
    end, [], UpperLetters).