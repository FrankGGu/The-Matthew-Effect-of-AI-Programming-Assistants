-module(solution).
-export([wiggle_sort/1]).

wiggle_sort(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),

    % Calculate the split point for the two halves.
    % Mid = ceil(N / 2)
    Mid = (N + 1) div 2, 

    % The first half contains the smaller elements (up to Mid elements).
    % The second half contains the larger elements (N - Mid elements).
    % We need to take elements from the end of these halves, so reverse them.
    RevSmallHalf = lists:reverse(lists:sublist(Sorted, 1, Mid)),
    RevLargeHalf = lists:reverse(lists:sublist(Sorted, Mid + 1, N - Mid)),

    % Interleave elements: small, large, small, large...
    % We build the result in reverse order and then reverse it once at the end.
    do_interleave(RevSmallHalf, RevLargeHalf, 0, N, []).

do_interleave(Small, Large, K, N, Acc) when K < N ->
    case K rem 2 of
        0 -> % Even index (0, 2, 4...), take from RevSmallHalf
            [H_S | T_S] = Small,
            do_interleave(T_S, Large, K + 1, N, [H_S | Acc]);
        1 -> % Odd index (1, 3, 5...), take from RevLargeHalf
            [H_L | T_L] = Large,
            do_interleave(Small, T_L, K + 1, N, [H_L | Acc])
    end;
do_interleave(_Small, _Large, _K, _N, Acc) ->
    % All elements processed, reverse the accumulated list to get the final order.
    lists:reverse(Acc).