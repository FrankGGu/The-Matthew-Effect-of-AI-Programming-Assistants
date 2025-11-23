-module(solution).
-export([largest_rectangle_area/1]).

-include_lib("kernel/include/array.hrl").

largest_rectangle_area(Heights) ->
    A = array:from_list(Heights),
    N = array:size(A),
    process(0, A, N, [], 0).

process(I, A, N, Stack, MaxArea) when I < N ->
    H_current = array:get(I, A),

    {NewStack, CurrentMaxArea} = pop_and_calculate(I, H_current, A, Stack, MaxArea),

    process(I + 1, A, N, [I | NewStack], CurrentMaxArea);

process(N, A, N, Stack, MaxArea) ->
    final_pop_and_calculate(N, A, Stack, MaxArea).

pop_and_calculate(I, H_current, A, Stack, MaxArea) ->
    case Stack of
        [] ->
            {Stack, MaxArea};
        [TopIdx | RestStack] when array:get(TopIdx, A) >= H_current ->
            H_popped = array:get(TopIdx, A),
            Width = case RestStack of
                        [] -> I;
                        [PrevTopIdx | _] -> I - PrevTopIdx - 1
                    end,
            NewMaxArea = max(MaxArea, H_popped * Width),
            pop_and_calculate(I, H_current, A, RestStack, NewMaxArea);
        _ ->
            {Stack, MaxArea}
    end.

final_pop_and_calculate(N, A, Stack, MaxArea) ->
    case Stack of
        [] ->
            MaxArea;
        [TopIdx | RestStack] ->
            H_popped = array:get(TopIdx, A),
            Width = case RestStack of
                        [] -> N;
                        [PrevTopIdx | _] -> N - PrevTopIdx - 1
                    end,
            NewMaxArea = max(MaxArea, H_popped * Width),
            final_pop_and_calculate(N, A, RestStack, NewMaxArea)
    end.