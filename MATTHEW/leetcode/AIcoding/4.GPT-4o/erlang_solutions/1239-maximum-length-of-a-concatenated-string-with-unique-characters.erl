-module(solution).
-export([maxLength/1]).

maxLength(Strs) ->
    maxLength(Strs, [], 0).

maxLength([], _, Max) ->
    Max;
maxLength([H | T], Acc, Max) ->
    case can_concat(H, Acc) of
        true -> 
            NewAcc = lists:append(Acc, H),
            NewMax = max(Max, length(NewAcc)),
            maxLength(T, NewAcc, NewMax);
        false -> 
            maxLength(T, Acc, Max)
    end.

can_concat(Str, Acc) ->
    UniqueChars = lists:usort(string:to_list(Str)),
    lists:all(fun(C) -> not lists:member(C, Acc) end, UniqueChars).