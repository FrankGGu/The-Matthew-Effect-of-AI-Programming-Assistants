-module(solution).
-export([building_boxes/1]).

triangular(K) when K < 0 -> 0;
triangular(K) -> K * (K + 1) div 2.

tetra(K) when K < 0 -> 0;
tetra(K) -> K * (K + 1) * (K + 2) div 6.

building_boxes(N) ->
    %% Binary search for the smallest K_pyramid such that a full pyramid of height K_pyramid
    %% can contain N boxes.
    %% The upper bound for K is chosen such that tetra(K) exceeds 10^9.
    %% tetra(2000) is approximately 1.3 * 10^9.
    Low = 1,
    High = 2000, 

    K_pyramid = binary_search_k(Low, High, N),

    %% Calculate the number of boxes in a full pyramid of height K_pyramid-1.
    N_prev_pyramid = tetra(K_pyramid - 1),

    %% Calculate the remaining boxes needed after filling the (K_pyramid-1) pyramid.
    RemainingN = N - N_prev_pyramid,

    %% Calculate the number of boxes on the floor for a base of size K_pyramid-1.
    FloorMoves_prev = triangular(K_pyramid - 1),

    %% If the remaining boxes can be placed on top of the (K_pyramid-1) base
    %% without extending the base (i.e., without increasing floor moves),
    %% then FloorMoves_prev is the answer.
    %% Otherwise, we need a base of size K_pyramid.
    case RemainingN =< FloorMoves_prev of
        true ->
            FloorMoves_prev;
        false ->
            triangular(K_pyramid)
    end.

binary_search_k(Low, High, N) ->
    case Low > High of
        true -> Low; %% Low is the smallest k that satisfies the condition
        false ->
            Mid = Low + (High - Low) div 2,
            NumBoxes = tetra(Mid),
            case NumBoxes >= N of
                true -> binary_search_k(Low, Mid - 1, N);
                false -> binary_search_k(Mid + 1, High, N)
            end
    end.