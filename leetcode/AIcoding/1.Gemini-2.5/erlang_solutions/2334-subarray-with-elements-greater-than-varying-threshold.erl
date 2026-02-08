-module(solution).
-export([satisfies_threshold/2]).

satisfies_threshold(Nums, Threshold) ->
    N = length(Nums),
    NumsArray = array:from_list(Nums),

    Left = build_left_array(NumsArray, N),
    Right = build_right_array(NumsArray, N),

    check_subarrays(0, N, NumsArray, Left, Right, Threshold).

build_left_array(NumsArray, N) ->
    Left = array:new([{size, N}, {fixed, true}]),
    build_left_array_loop(0, N, NumsArray, [], Left).

build_left_array_loop(I, N, NumsArray, Stack, Left) when I < N ->
    CurrentNum = array:get(I, NumsArray),
    {NewStack, LeftVal} = pop_stack_for_left(CurrentNum, Stack, NumsArray),
    NewLeft = array:set(I, LeftVal, Left),
    build_left_array_loop(I + 1, N, NumsArray, [I | NewStack], NewLeft);
build_left_array_loop(_, _, _, _, Left) ->
    Left.

pop_stack_for_left(CurrentNum, [TopIdx | RestStack], NumsArray) ->
    TopNum = array:get(TopIdx, NumsArray),
    if
        TopNum >= CurrentNum ->
            pop_stack_for_left(CurrentNum, RestStack, NumsArray);
        true ->
            {[TopIdx | RestStack], TopIdx}
    end;
pop_stack_for_left(_, [], _) ->
    {[], -1}.

build_right_array(NumsArray, N) ->
    Right = array:new([{size, N}, {fixed, true}]),
    build_right_array_loop(N - 1, N, NumsArray, [], Right).

build_right_array_loop(I, N, NumsArray, Stack, Right) when I >= 0 ->
    CurrentNum = array:get(I, NumsArray),
    {NewStack, RightVal} = pop_stack_for_right(CurrentNum, Stack, NumsArray, N),
    NewRight = array:set(I, RightVal, Right),
    build_right_array_loop(I - 1, N, NumsArray, [I | NewStack], NewRight);
build_right_array_loop(_, _, _, _, Right) ->
    Right.

pop_stack_for_right(CurrentNum, [TopIdx | RestStack], NumsArray, N) ->
    TopNum = array:get(TopIdx, NumsArray),
    if
        TopNum >= CurrentNum ->
            pop_stack_for_right(CurrentNum, RestStack, NumsArray, N);
        true ->
            {[TopIdx | RestStack], TopIdx}
    end;
pop_stack_for_right(_, [], _, N) ->
    {[], N}.

check_subarrays(I, N, NumsArray, Left, Right, Threshold) when I < N ->
    Num_I = array:get(I, NumsArray),
    Left_I = array:get(I, Left),
    Right_I = array:get(I, Right),

    Len = Right_I - Left_I - 1,

    if Num_I > Threshold * Len ->
        Len;
    true ->
        check_subarrays(I + 1, N, NumsArray, Left, Right, Threshold)
    end;
check_subarrays(_, _, _, _, _, _) ->
    -1.