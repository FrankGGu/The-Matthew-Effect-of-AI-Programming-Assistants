-module(solution).
-export([partition/1]).

partition(S) ->
    backtrack(S, 1, [], []).

backtrack(S, StartIndex, CurrentPartition, AllPartitionsAcc) ->
    Len = length(S),
    if
        StartIndex > Len ->
            [lists:reverse(CurrentPartition) | AllPartitionsAcc];
        true ->
            lists:foldl(fun(EndIndex, AccFromPrevEndIndex) ->
                SubstrLen = EndIndex - StartIndex + 1,
                Substr = lists:sublist(S, StartIndex, SubstrLen),
                if
                    is_palindrome(Substr) ->
                        backtrack(S, EndIndex + 1, [Substr | CurrentPartition], AccFromPrevEndIndex);
                    true ->
                        AccFromPrevEndIndex
                end
            end, AllPartitionsAcc, lists:seq(StartIndex, Len))
    end.

is_palindrome(S) ->
    S == lists:reverse(S).