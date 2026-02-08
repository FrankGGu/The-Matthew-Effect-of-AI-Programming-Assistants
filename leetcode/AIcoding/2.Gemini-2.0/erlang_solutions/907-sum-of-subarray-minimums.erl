-module(subarray_minimums).
-export([sumSubarrayMins/1]).

sumSubarrayMins(Arr) ->
    sumSubarrayMins(Arr, length(Arr), 1000000007).

sumSubarrayMins(Arr, N, Mod) ->
    Stack1 = [],
    Stack2 = [],
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),

    Left1 = calculateLeft(Arr, N, Stack1, Left),
    Right1 = calculateRight(Arr, N, Stack2, Right),

    lists:foldl(fun(I, Acc) ->
                        Acc1 = (Arr !! (I - 1)) * (Left1 !! (I - 1)) * (Right1 !! (I - 1));
                        (Acc + Acc1) rem Mod
                end, 0, lists:seq(1, N)).

calculateLeft(Arr, N, Stack, Left) ->
    lists:foldl(fun(I, {S, L}) ->
                        {NewS, NewL} = calculateLeftHelper(Arr, S, L, I);
                        {NewS, NewL}
                end, {Stack, Left}, lists:seq(1, N))
    || lists:nth(2, calculateLeft(Arr, N, Stack, Left)).

calculateLeftHelper(Arr, Stack, Left, I) ->
    {NewStack, Res} = calculateLeftHelper1(Arr, Stack, Left, I, 0);
    {[I|NewStack], lists:nth(I, lists:replace_nth(I - 1, Res, Left))}.

calculateLeftHelper1(Arr, Stack, Left, I, Acc) ->
    case Stack of
        [] ->
            {Stack, Acc + I};
        [H|T] ->
            if Arr !! (H - 1) >= Arr !! (I - 1) then
                calculateLeftHelper1(Arr, T, Left, I, Acc + (I - H))
            else
                {Stack, Acc + I}
            end
    end.

calculateRight(Arr, N, Stack, Right) ->
    lists:foldl(fun(I, {S, R}) ->
                        {NewS, NewR} = calculateRightHelper(Arr, S, R, I, N);
                        {NewS, NewR}
                end, {Stack, Right}, lists:seq(1, N))
    || lists:nth(2, calculateRight(Arr, N, Stack, Right)).

calculateRightHelper(Arr, Stack, Right, I, N) ->
    {NewStack, Res} = calculateRightHelper1(Arr, Stack, Right, I, N, 0);
    {[I|NewStack], lists:nth(I, lists:replace_nth(I - 1, Res, Right))}.

calculateRightHelper1(Arr, Stack, Right, I, N, Acc) ->
    case Stack of
        [] ->
            {Stack, Acc + (N - I + 1)};
        [H|T] ->
            if Arr !! (H - 1) > Arr !! (I - 1) then
                calculateRightHelper1(Arr, T, Right, I, N, Acc + (H - I))
            else
                {Stack, Acc + (N - I + 1)}
            end
    end.