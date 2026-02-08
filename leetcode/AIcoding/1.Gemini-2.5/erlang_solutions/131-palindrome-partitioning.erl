-module(solution).
-export([partition/1]).

partition(S) ->
    backtrack(S, 1, []).

backtrack(S, StartIndex, CurrentPartition) when StartIndex > length(S) ->
    [lists:reverse(CurrentPartition)];
backtrack(S, StartIndex, CurrentPartition) ->
    LenS = length(S),
    lists:foldl(fun(EndIndex, Acc) ->
                    SubString = lists:sublist(S, StartIndex, EndIndex - StartIndex + 1),
                    case is_palindrome(SubString) of
                        true ->
                            backtrack(S, EndIndex + 1, [SubString | CurrentPartition]) ++ Acc;
                        false ->
                            Acc
                    end
                end, [], lists:seq(StartIndex, LenS)).

is_palindrome(Str) ->
    Str == lists:reverse(Str).