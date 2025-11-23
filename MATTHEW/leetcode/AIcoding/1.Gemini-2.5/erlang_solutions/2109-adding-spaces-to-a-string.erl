-module(solution).
-export([add_spaces/2]).

add_spaces(S, Spaces) ->
    % The helper function builds the result list in reverse order
    % by prepending segments and spaces to an accumulator.
    % Finally, lists:reverse/1 is called once to get the correct order.
    lists:reverse(add_spaces_helper(S, Spaces, 0, [])).

add_spaces_helper(S, [], CurrentSIdx, Acc) ->
    % Base case: No more spaces to insert.
    % Append the remaining part of the string S from CurrentSIdx to the end.
    % This remaining segment (S[CurrentSIdx] to S[length-1]) needs to be reversed
    % before prepending to the accumulator.
    lists:reverse(lists:sublist(S, CurrentSIdx + 1)) ++ Acc;
add_spaces_helper(S, [SpaceIdx | RestSpaces], CurrentSIdx, Acc) ->
    % Recursive case: Process the current SpaceIdx.
    % SpaceIdx is the 0-based index in S where a space should be inserted.
    % We need to take the segment of characters from S[CurrentSIdx] up to S[SpaceIdx - 1].
    % The length of this segment is SpaceIdx - CurrentSIdx.
    SegmentLength = SpaceIdx - CurrentSIdx,

    % Extract the segment using lists:sublist/3 (which is 1-indexed).
    % The segment also needs to be reversed before prepending to the accumulator.
    Segment = lists:reverse(lists:sublist(S, CurrentSIdx + 1, SegmentLength)),

    % Prepend the space (ASCII 32) and the reversed segment to the accumulator.
    % Then recurse with the rest of the spaces and update CurrentSIdx to SpaceIdx.
    add_spaces_helper(S, RestSpaces, SpaceIdx, [32 | Segment ++ Acc]).