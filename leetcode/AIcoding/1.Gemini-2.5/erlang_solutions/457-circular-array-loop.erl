-module(solution).
-export([circularArrayLoop/1]).

circularArrayLoop(Nums) ->
    N = length(Nums),
    NumsTuple = list_to_tuple(Nums),

    check_loops(NumsTuple, N, 0).

check_loops(_Nums, N, N) ->
    false;
check_loops(Nums, N, I) ->
    CurrentVal = element(I + 1, Nums),

    IsForward = CurrentVal > 0,

    FoundLoop = find_cycle(Nums, N, I, I, IsForward),

    if
        FoundLoop ->
            true;
        true ->
            check_loops(Nums, N, I + 1)
    end.

get_next_valid_idx(Nums, N, CurrentIdx, IsForward) ->
    Val = element(CurrentIdx + 1, Nums),

    if
        (Val > 0) /= IsForward -> -1;
        true ->
            NextIdx = (CurrentIdx + Val) rem N,
            AdjustedNextIdx = if NextIdx < 0 -> NextIdx + N; true -> NextIdx end,

            if
                AdjustedNextIdx == CurrentIdx -> -1;
                true -> AdjustedNextIdx
            end
    end.

find_cycle(Nums, N, Slow, Fast, IsForward) ->
    NextSlow = get_next_valid_idx(Nums, N, Slow, IsForward),

    NextFast1 = get_next_valid_idx(Nums, N, Fast, IsForward),
    NextFast2 = if NextFast1 == -1 -> -1; true -> get_next_valid_idx(Nums, N, NextFast1, IsForward) end,

    if
        NextSlow == -1 orelse NextFast1 == -1 orelse NextFast2 == -1 ->
            false;
        NextSlow == NextFast2 ->
            true;
        true ->
            find_cycle(Nums, N, NextSlow, NextFast2, IsForward)
    end.