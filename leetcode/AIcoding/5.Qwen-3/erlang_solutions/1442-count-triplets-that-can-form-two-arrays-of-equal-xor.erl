-module(solution).
-export([count_triplets/1]).

count_triplets(A) ->
    N = length(A),
    Count = 0,
    count_triplets(A, N, 0, Count).

count_triplets(_, _, I, Acc) when I >= N ->
    Acc;
count_triplets(A, N, I, Acc) ->
    J = I + 1,
    count_triplets(A, N, I, J, Acc).

count_triplets(_, _, _, J, Acc) when J >= N ->
    count_triplets(A, N, I + 1, Acc);
count_triplets(A, N, I, J, Acc) ->
    K = J + 1,
    count_triplets(A, N, I, J, K, Acc).

count_triplets(_, _, _, _, K, Acc) when K >= N ->
    count_triplets(A, N, I, J + 1, Acc);
count_triplets(A, N, I, J, K, Acc) ->
    XorIJ = xor_subarray(A, I, J),
    XorJK = xor_subarray(A, J, K),
    if
        XorIJ == XorJK ->
            count_triplets(A, N, I, J, K + 1, Acc + 1);
        true ->
            count_triplets(A, N, I, J, K + 1, Acc)
    end.

xor_subarray(A, Start, End) ->
    xor_subarray(A, Start, End, 0).

xor_subarray(_, End, End, Acc) ->
    Acc;
xor_subarray(A, Start, End, Acc) ->
    Val = lists:nth(Start + 1, A),
    xor_subarray(A, Start + 1, End, Acc bxor Val).