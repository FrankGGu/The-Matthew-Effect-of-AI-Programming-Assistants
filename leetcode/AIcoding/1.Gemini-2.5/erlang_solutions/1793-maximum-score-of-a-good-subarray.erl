-module(solution).
-export([maximum_score/2]).

maximum_score(Nums, K) ->
    Arr = array:from_list(Nums),
    N = array:size(Arr),
    Left = K,
    Right = K,
    MinVal = array:get(K, Arr),
    MaxScore = MinVal,
    maximum_score_loop(Left, Right, MinVal, MaxScore, Arr, N).

maximum_score_loop(Left, Right, MinVal, MaxScore, Arr, N) ->
    if
        Left == 0 andalso Right == N - 1 ->
            MaxScore;
        Left == 0 ->
            NewRight = Right + 1,
            ValAtNewRight = array:get(NewRight, Arr),
            NewMinVal = min(MinVal, ValAtNewRight),
            NewScore = NewMinVal * (NewRight - Left + 1),
            maximum_score_loop(Left, NewRight, NewMinVal, max(MaxScore, NewScore), Arr, N);
        Right == N - 1 ->
            NewLeft = Left - 1,
            ValAtNewLeft = array:get(NewLeft, Arr),
            NewMinVal = min(MinVal, ValAtNewLeft),
            NewScore = NewMinVal * (Right - NewLeft + 1),
            maximum_score_loop(NewLeft, Right, NewMinVal, max(MaxScore, NewScore), Arr, N);
        array:get(Left - 1, Arr) < array:get(Right + 1, Arr) ->
            NewRight = Right + 1,
            ValAtNewRight = array:get(NewRight, Arr),
            NewMinVal = min(MinVal, ValAtNewRight),
            NewScore = NewMinVal * (NewRight - Left + 1),
            maximum_score_loop(Left, NewRight, NewMinVal, max(MaxScore, NewScore), Arr, N);
        true ->
            NewLeft = Left - 1,
            ValAtNewLeft = array:get(NewLeft, Arr),
            NewMinVal = min(MinVal, ValAtNewLeft),
            NewScore = NewMinVal * (Right - NewLeft + 1),
            maximum_score_loop(NewLeft, Right, NewMinVal, max(MaxScore, NewScore), Arr, N)
    end.