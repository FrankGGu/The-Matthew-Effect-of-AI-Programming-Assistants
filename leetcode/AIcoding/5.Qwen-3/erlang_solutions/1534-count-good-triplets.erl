-module(solution).
-export([count_good_triplets/2]).

count_good_triplets(A, B) ->
    count_good_triplets(A, B, 0, 0).

count_good_triplets([], _, _, Count) ->
    Count;
count_good_triplets([H | T], B, I, Count) ->
    count_good_triplets(T, B, I + 1, count_good_triplets_helper(T, H, B, I, Count)).

count_good_triplets_helper([], _, _, _, Count) ->
    Count;
count_good_triplets_helper([J | K], IVal, B, I, Count) ->
    JVal = J,
    case abs(IVal - JVal) =< B of
        true ->
            count_good_triplets_helper(K, IVal, B, I, count_good_triplets_helper2(K, JVal, B, I, Count));
        false ->
            count_good_triplets_helper(K, IVal, B, I, Count)
    end.

count_good_triplets_helper2([], _, _, _, Count) ->
    Count;
count_good_triplets_helper2([K | L], JVal, B, I, Count) ->
    KVal = K,
    if
        abs(JVal - KVal) =< B andalso abs(IVal - KVal) =< B ->
            count_good_triplets_helper2(L, JVal, B, I, Count + 1);
        true ->
            count_good_triplets_helper2(L, JVal, B, I, Count)
    end.