-module(solution).
-export([count_good_triplets/4]).

count_good_triplets(A, a, b, c) ->
    count_good_triplets_helper(A, a, b, c, 0, 0).

count_good_triplets_helper([], _, _, _, Count, _) -> Count;
count_good_triplets_helper([H | T], a, b, c, Count, Index) ->
    NewCount = lists:foldl(fun(X, Acc) ->
        case (H - X) > a andalso (H - X) < b of
            true -> Acc + 1;
            false -> Acc
        end
    end, Count, T),
    count_good_triplets_helper(T, a, b, c, NewCount, Index + 1).