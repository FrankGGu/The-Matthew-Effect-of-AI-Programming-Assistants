-module(solution).
-export([countPairs/2]).

countPairs(A, k) ->
    count_pairs(A, k, 0).

count_pairs([], _, Count) ->
    Count;
count_pairs([H | T], K, Count) ->
    NewCount = lists:foldl(fun(X, Acc) ->
        if
            H == X andalso H rem K == 0 -> Acc + 1;
            true -> Acc
        end
    end, Count, T),
    count_pairs(T, K, NewCount).