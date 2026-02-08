-module(solution).
-export([odd_even_jump/1]).

odd_even_jump(A) ->
    N = length(A),
    if N =:= 0 -> 0;
       N =:= 1 -> 1;
       true ->
            {NextOdd, NextEven} = find_next_jumps(A),

            % dp_odd[i] = true if we can reach end with an odd jump from i
            % dp_even[i] = true if we can reach end with an even jump from i
            DpOdd = maps:put(N-1, true, maps:new()),
            DpEven = maps:put(N-1, true, maps:new()),

            % Iterate backwards from N-2 down to 0
            {_FinalDpOdd, _FinalDpEven, Count} = lists:foldl(
                fun(I, {AccDpOdd, AccDpEven, AccCount}) ->
                    % Calculate dp_odd[I]
                    NewDpOddI =
                        case maps:find(I, NextOdd) of
                            {ok, J} -> maps:get(J, AccDpEven, false);
                            error -> false
                        end,

                    % Calculate dp_even[I]
                    NewDpEvenI =
                        case maps:find(I, NextEven) of
                            {ok, K} -> maps:get(K, AccDpOdd, false);
                            error -> false
                        end,

                    % Update maps
                    UpdatedDpOdd = maps:put(I, NewDpOddI, AccDpOdd),
                    UpdatedDpEven = maps:put(I, NewDpEvenI, AccDpEven),

                    % Update count if dp_odd[I] is true
                    NewCount = if NewDpOddI -> AccCount + 1; true -> AccCount end,

                    {UpdatedDpOdd, UpdatedDpEven, NewCount}
                end,
                {DpOdd, DpEven, 1}, % Initial state: N-1 is a good starting point (dp_odd[N-1] is true)
                lists:seq(N-2, 0, -1)
            ),
            Count
    end.

find_next_jumps(A) ->
    N = length(A),
    Indices = lists:seq(0, N-1),
    IndexedA = lists:zip(A, Indices),

    % Helper function to process the stack for finding next greater/smaller
    % Stack stores indices in decreasing order.
    % When processing CurrentIdx, pop elements from Stack that are smaller than CurrentIdx.
    % For each popped element PopIdx, CurrentIdx is its next jump.
    ProcessStack = fun(CurrentIdx, AccNextJumps, AccStack) ->
        case AccStack of
            [] -> {AccNextJumps, []};
            [TopIdx | RestStack] when TopIdx < CurrentIdx ->
                NewAccNextJumps = maps:put(TopIdx, CurrentIdx, AccNextJumps),
                ProcessStack(CurrentIdx, NewAccNextJumps, RestStack);
            _ -> {AccNextJumps, AccStack}
        end
    end,

    % --- Odd Jumps (next greater or equal) ---
    % Sort by value ascending, then by index ascending (for tie-breaking to get smallest index)
    SortedAsc = lists:sort(fun({Val1, Idx1}, {Val2, Idx2}) ->
                               if Val1 =:= Val2 -> Idx1 < Idx2;
                                  true -> Val1 < Val2
                               end
                           end, IndexedA),
    {NextOddJumpsMap, _} = lists:foldl(fun({_Val, CurrentIdx}, {AccNextJumps, AccStack}) ->
                                           {UpdatedAccNextJumps, RemainingStack} =
                                               ProcessStack(CurrentIdx, AccNextJumps, AccStack),
                                           {UpdatedAccNextJumps, [CurrentIdx | RemainingStack]}
                                       end, {maps:new(), []}, SortedAsc),

    % --- Even Jumps (next smaller or equal) ---
    % Sort by value descending, then by index ascending (for tie-breaking to get smallest index)
    SortedDesc = lists:sort(fun({Val1, Idx1}, {Val2, Idx2}) ->
                               if Val1 =:= Val2 -> Idx1 < Idx2;
                                  true -> Val1 > Val2
                               end
                           end, IndexedA),
    {NextEvenJumpsMap, _} = lists:foldl(fun({_Val, CurrentIdx}, {AccNextJumps, AccStack}) ->
                                            {UpdatedAccNextJumps, RemainingStack} =
                                                ProcessStack(CurrentIdx, AccNextJumps, AccStack),
                                            {UpdatedAccNextJumps, [CurrentIdx | RemainingStack]}
                                        end, {maps:new(), []}, SortedDesc),

    {NextOddJumpsMap, NextEvenJumpsMap}.