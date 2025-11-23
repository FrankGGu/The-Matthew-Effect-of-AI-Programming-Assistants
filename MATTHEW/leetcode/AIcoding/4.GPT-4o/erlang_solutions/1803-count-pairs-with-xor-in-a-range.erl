-module(solution).
-export([countPairs/3]).

countPairs(X, L, R) ->
    count_pairs(X, L, R, 0).

count_pairs([], _, _, Count) -> 
    Count;
count_pairs([H | T], L, R, Count) ->
    NewCount = Count + count_in_range(H, L, R),
    count_pairs(T, L, R, NewCount).

count_in_range(X, L, R) ->
    case X >= L andalso X =< R of
        true -> 1;
        false -> 0
    end.