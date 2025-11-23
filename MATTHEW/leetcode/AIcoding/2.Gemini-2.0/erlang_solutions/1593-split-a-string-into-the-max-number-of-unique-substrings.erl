-module(split_string).
-export([max_unique_split/1]).

max_unique_split(S) ->
    max_unique_split(S, []).

max_unique_split("", Acc) ->
    length(Acc);
max_unique_split(S, Acc) ->
    Len = length(S),
    max_unique_split_helper(S, Acc, 1, Len).

max_unique_split_helper(S, Acc, Start, Len) ->
    if Start > Len then
        length(Acc)
    else
        Sub = string:sub(S, 1, Start),
        if lists:member(Sub, Acc) then
            max_unique_split_helper(S, Acc, Start + 1, Len)
        else
            Rest = string:sub(S, Start + 1, Len - Start),
            NewAcc = [Sub | Acc],
            RestResult = max_unique_split(Rest, NewAcc),
            NoRestResult = max_unique_split_helper(S, Acc, Start + 1, Len),
            max(RestResult, NoRestResult)
        end
    end.