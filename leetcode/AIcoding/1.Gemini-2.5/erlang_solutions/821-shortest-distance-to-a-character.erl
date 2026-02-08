-module(solution).
-export([shortestToChar/2]).

shortestToChar(S, C) ->
    % Pass 1: Left to right
    % Calculate distance to the nearest 'C' on the left
    % Initial LastCIdx is a very small number (e.g., -1000000) to represent "no C seen yet"
    % This ensures the initial distances are effectively infinity.
    LeftDists = calculate_left_distances(S, C, -1000000, 0, []),

    % Pass 2: Right to left
    % Calculate distance to the nearest 'C' on the right
    % This is done by reversing the string, calculating "left" distances on the reversed string,
    % and then reversing the result.
    % The `CurrentIdx - NewLastCIdx` logic on the reversed string effectively calculates
    % `next_c_idx_original - current_idx_original`.
    S_rev = lists:reverse(S),
    RightDists_temp = calculate_left_distances(S_rev, C, -1000000, 0, []),
    RightDists = lists:reverse(RightDists_temp),

    % Combine distances by taking the minimum of corresponding elements
    combine_distances(LeftDists, RightDists, []).

calculate_left_distances([], _C, _LastCIdx, _CurrentIdx, Acc) ->
    lists:reverse(Acc);
calculate_left_distances([H|T], C, LastCIdx, CurrentIdx, Acc) ->
    NewLastCIdx = if H == C -> CurrentIdx;
                    true -> LastCIdx
                  end,
    Dist = CurrentIdx - NewLastCIdx,
    calculate_left_distances(T, C, NewLastCIdx, CurrentIdx + 1, [Dist|Acc]).

combine_distances([], [], Acc) ->
    lists:reverse(Acc);
combine_distances([Ld|LdT], [Rd|RdT], Acc) ->
    MinDist = min(Ld, Rd),
    combine_distances(LdT, RdT, [MinDist|Acc]).