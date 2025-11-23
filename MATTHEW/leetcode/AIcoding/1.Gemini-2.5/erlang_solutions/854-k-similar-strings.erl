-module(solution).
-export([k_similar/2]).

-include_lib("stdlib/include/array.hrl"). % For array type definition if needed, though not strictly required for compilation.

k_similar(A, B) ->
    A_list = string:to_list(A),
    B_list = string:to_list(B),
    N = length(A_list),

    A_array = array:from_list(A_list),
    B_array = array:from_list(B_list),

    Queue = queue:in({{A_array, 0}}, queue:new()),
    Visited = sets:add(A_array, sets:new()),

    bfs(Queue, Visited, B_array, N).

bfs(Queue, Visited, B_array, N) ->
    case queue:out(Queue) of
        {{value, {CurrentArray, Swaps}}, NewQueue} ->
            if CurrentArray == B_array ->
                Swaps;
            true ->
                NextStates = get_next_states(CurrentArray, B_array, N),
                {NewQueue2, Visited2} = lists:foldl(
                    fun(NextArray, {AccQueue, AccVisited}) ->
                        if not sets:is_element(NextArray, AccVisited) ->
                            {queue:in({{NextArray, Swaps + 1}}, AccQueue), sets:add(NextArray, AccVisited)};
                        true ->
                            {AccQueue, AccVisited}
                        end
                    end,
                    {NewQueue, Visited},
                    NextStates
                ),
                bfs(NewQueue2, Visited2, B_array, N)
            end;
        {empty, _} ->
            % This case should ideally not be reached if a solution is guaranteed.
            % Returning -1 or throwing an error would be appropriate depending on problem spec.
            -1 
    end.

get_next_states(CurrentArray, B_array, N) ->
    FirstDiffIdx = find_first_diff_idx(CurrentArray, B_array, 0, N),

    if FirstDiffIdx == N ->
        [];
    true ->
        TargetCharForI = array:get(FirstDiffIdx, B_array),

        lists:foldl(
            fun(J, Acc) ->
                if J > FirstDiffIdx, array:get(J, CurrentArray) == TargetCharForI ->
                    ValI = array:get(FirstDiffIdx, CurrentArray),
                    ValJ = array:get(J, CurrentArray),
                    Array2 = array:set(FirstDiffIdx, ValJ, CurrentArray),
                    Array3 = array:set(J, ValI, Array2),
                    [Array3 | Acc];
                true ->
                    Acc
                end
            end,
            [],
            lists:seq(FirstDiffIdx + 1, N - 1)
        )
    end.

find_first_diff_idx(S1_array, S2_array, Idx, N) ->
    if Idx == N ->
        N;
    array:get(Idx, S1_array) == array:get(Idx, S2_array) ->
        find_first_diff_idx(S1_array, S2_array, Idx + 1, N);
    true ->
        Idx
    end.