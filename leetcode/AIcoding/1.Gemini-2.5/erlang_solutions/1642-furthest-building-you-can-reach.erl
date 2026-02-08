-module(solution).
-export([furthest_building/3]).

furthest_building(Heights, Bricks, Ladders) ->
    N = length(Heights),
    % Convert the list of heights to a tuple for O(1) element access.
    % This is crucial for performance with large N.
    HeightsTuple = list_to_tuple(Heights),
    furthest_building_impl(HeightsTuple, 0, N, Bricks, Ladders, gb_trees:empty()).

furthest_building_impl(HeightsTuple, Idx, N, Bricks, Ladders, PQ) when Idx < N - 1 ->
    % Get current and next building heights using 1-based indexing for tuples
    H_curr = element(Idx + 1, HeightsTuple),
    H_next = element(Idx + 2, HeightsTuple),

    Diff = H_next - H_curr,

    if Diff =< 0 ->
        % No resources needed, just move to the next building
        furthest_building_impl(HeightsTuple, Idx + 1, N, Bricks, Ladders, PQ);
    true -> % Diff > 0, need resources
        % Try to use bricks first
        NewBricks = Bricks - Diff,
        % Add this difference to our priority queue (max-heap) of brick costs.
        % We use gb_trees as a frequency map for the differences,
        % allowing us to efficiently find and remove the largest difference.
        NewPQ = add_to_pq(Diff, PQ),

        if NewBricks >= 0 ->
            % Bricks are sufficient, continue to the next building
            furthest_building_impl(HeightsTuple, Idx + 1, N, NewBricks, Ladders, NewPQ);
        true -> % NewBricks < 0, we ran out of bricks
            if Ladders > 0 ->
                % We have ladders. Use one for the largest brick cost paid so far
                % to free up the most bricks.
                {MaxDiff, MaxCount} = gb_trees:largest(NewPQ),

                % Restore bricks by adding back the MaxDiff (which is now covered by a ladder)
                BricksFreed = NewBricks + MaxDiff,
                NewLadders = Ladders - 1,

                % Remove MaxDiff from the priority queue
                PQ_after_ladder = remove_from_pq(MaxDiff, NewPQ, MaxCount),

                furthest_building_impl(HeightsTuple, Idx + 1, N, BricksFreed, NewLadders, PQ_after_ladder);
            true -> % No ladders left, cannot proceed
                Idx % Return the current building index (0-based) as the furthest reachable
            end
        end
    end;
furthest_building_impl(_HeightsTuple, Idx, _N, _Bricks, _Ladders, _PQ) ->
    % Reached the end of the buildings (Idx = N - 1) or the last building was processed.
    % Return the current building index as the furthest reachable.
    Idx.

add_to_pq(Val, PQ) ->
    case gb_trees:lookup(Val, PQ) of
        {value, Count} -> gb_trees:update(Val, Count + 1, PQ);
        _ -> gb_trees:insert(Val, 1, PQ)
    end.

remove_from_pq(Val, PQ, Count) ->
    if Count > 1 -> gb_trees:update(Val, Count - 1, PQ);
    true -> gb_trees:delete(Val, PQ)
    end.