-module(solution).
-export([max_building_height/2]).

max_building_height(N, Restrictions) ->
    % 1. Add implicit restriction for building 1 (height 0) and sort/deduplicate.
    % Restrictions are represented as [{Position, Height}] tuples.
    InitialRestrictions = [{1, 0}] ++ Restrictions,
    SortedUniqueRestrictions = sort_and_deduplicate(InitialRestrictions),

    % 2. Ensure building N is covered. If not explicitly restricted, add a default max height.
    % If restricted, ensure its height is not greater than N-1 (max possible height for building N).
    FinalRestrictions = add_n_restriction(N, SortedUniqueRestrictions),

    % 3. First pass (left to right) to apply height constraints: height[i] <= height[i-1] + 1.
    LeftPassResult = left_pass(FinalRestrictions),

    % 4. Second pass (right to left) to apply height constraints: height[i] <= height[i+1] + 1.
    RightPassResult = right_pass(LeftPassResult),

    % 5. Calculate the maximum possible height among all buildings, including those between restricted points.
    calculate_max_height(RightPassResult).

sort_and_deduplicate(Restrictions) ->
    Sorted = lists:sort(fun({P1,_}, {P2,_}) -> P1 < P2 end, Restrictions),
    deduplicate_loop(Sorted).

deduplicate_loop([]) -> [];
deduplicate_loop([H|T]) ->
    deduplicate_loop_inner(T, [H]).

deduplicate_loop_inner([], Acc) ->
    lists:reverse(Acc);
deduplicate_loop_inner([{P,H}|T], [{PrevP,PrevH}|AccT]) when PrevP == P ->
    deduplicate_loop_inner(T, [{P,min(H,PrevH)}|AccT]);
deduplicate_loop_inner([{P,H}|T], Acc) ->
    deduplicate_loop_inner(T, [{P,H}|Acc]).

add_n_restriction(N, R) ->
    case lists:keyfind(N, 1, R) of
        false -> R ++ [{N, N-1}];
        {N, H_N} -> lists:keyreplace(N, 1, R, {N, min(H_N, N-1)})
    end.

left_pass(R) ->
    left_pass_loop(R, 1, 0, []). % (List, PreviousPosition, PreviousHeight, Accumulator)

left_pass_loop([], _, _, Acc) ->
    lists:reverse(Acc);
left_pass_loop([{Pos, H}|T], PrevPos, PrevH, Acc) ->
    % The current building's height cannot exceed its given restriction H,
    % nor can it exceed the previous building's height plus the distance.
    NewH = min(H, PrevH + (Pos - PrevPos)),
    left_pass_loop(T, Pos, NewH, [{Pos, NewH}|Acc]).

right_pass(R) ->
    ReversedR = lists:reverse(R),
    {_LastPos, LastH} = hd(R), % Get the height of the last building (N) from the left pass result
    right_pass_loop(ReversedR, _LastPos, LastH, []). % (ReversedList, NextPosition, NextHeight, Accumulator)

right_pass_loop([], _, _, Acc) ->
    lists:reverse(Acc);
right_pass_loop([{Pos, H}|T], NextPos, NextH, Acc) ->
    % The current building's height cannot exceed its height from the left pass (H),
    % nor can it exceed the next building's height plus the distance.
    NewH = min(H, NextH + (NextPos - Pos)),
    right_pass_loop(T, Pos, NewH, [{Pos, NewH}|Acc]).

calculate_max_height(R) ->
    calculate_max_height_loop(R, 0).

calculate_max_height_loop([{P1,H1}, {P2,H2}|T], MaxAcc) ->
    % For any two adjacent restricted buildings (P1, H1) and (P2, H2),
    % the heights of buildings between them form a "tent" shape.
    % The maximum height in this segment is at the peak of the tent.
    Diff = P2 - P1,
    MaxBetween = (H1 + H2 + Diff) div 2,
    % The overall maximum height is the maximum of the current MaxAcc, H1, and the MaxBetween.
    MaxCurrent = max(MaxAcc, max(H1, MaxBetween)),
    calculate_max_height_loop([{P2,H2}|T], MaxCurrent);
calculate_max_height_loop([{P1,H1}], MaxAcc) ->
    % Base case: only one restricted building left, consider its height.
    max(MaxAcc, H1);
calculate_max_height_loop([], MaxAcc) ->
    % Base case: no restricted buildings left.
    MaxAcc.