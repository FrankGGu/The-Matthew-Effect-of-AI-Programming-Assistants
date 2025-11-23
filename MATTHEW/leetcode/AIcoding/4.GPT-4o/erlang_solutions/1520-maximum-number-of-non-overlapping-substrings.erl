-module(solution).
-export([max_num_of_substrings/1]).

max_num_of_substrings(Str) ->
    Length = length(Str),
    Last = lists:duplicate(26, -1),
    Prefix = lists:duplicate(Length + 1, 0),
    Chars = string:to_lower(Str),
    lists:foldl(fun(X, {Idx, Acc}) ->
        Char = element(1, X) - $a,
        NewAcc = lists:sublist(Acc, 0, Idx + 1) ++ [Char],
        NewLast = lists:update_at(Char + 1, fun(_) -> Idx + 1 end, Last),
        {Idx + 1, NewLast}
    end, {0, []}, lists:zip(lists:seq(0, Length - 1), Chars)),
    Max = lists:foldl(fun(X, Acc) ->
        Char = element(1, X) - $a,
        Min = lists:min(lists:sublist(Acc, Char + 1)),
        NewAcc = lists:sublist(Acc, 0, Char + 1) ++ [Min],
        NewAcc
    end, Last, lists:seq(0, 25)),
    lists:foldl(fun(X, Acc) ->
        {Start, End} = X,
        if
            Start =< End ->
                Acc ++ [[Start, End]]
            true ->
                Acc
        end
    end, [], lists:zip(lists:seq(0, Length), Max)).