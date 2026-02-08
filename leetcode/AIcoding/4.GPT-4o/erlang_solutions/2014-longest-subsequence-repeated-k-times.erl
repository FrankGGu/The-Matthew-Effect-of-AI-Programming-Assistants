-module(solution).
-export([longest_subsequence/2]).

longest_subsequence(A, K) ->
    N = length(A),
    MaxLength = 0,
    lists:foldl(fun(I, Acc) ->
        SubSeq = lists:sublist(A, I, N - I + 1),
        {Length, Count} = count_repeats(SubSeq, A),
        case Count >= K of
            true -> max(Length, Acc);
            false -> Acc
        end
    end, MaxLength, lists:seq(1, N).

count_repeats(SubSeq, A) ->
    Length = length(SubSeq),
    Count = lists:foldl(fun(X, Acc) ->
        if
            lists:prefix(A, X) -> Acc + 1;
            true -> Acc
        end
    end, 0, lists:sublist(A, 1, length(A) - Length + 1)),
    {Length, Count}.