-module(solution).
-export([count_good_triplets/2]).

count_good_triplets(A, B) ->
    count_good_triplets(A, B, 0, 0).

count_good_triplets([], _, _, Count) ->
    Count;
count_good_triplets([H | T], B, Index, Count) ->
    NewCount = count_good_triplets_helper(T, H, B, Index, 0),
    count_good_triplets(T, B, Index + 1, Count + NewCount).

count_good_triplets_helper([], _, _, _, Count) ->
    Count;
count_good_triplets_helper([H | T], X, B, Index, Count) ->
    if
        abs(X - H) =< B ->
            count_good_triplets_helper(T, X, B, Index, Count + 1);
        true ->
            count_good_triplets_helper(T, X, B, Index, Count)
    end.