-module(solution).
-export([count_complete_substrings/2]).

count_complete_substrings(S, K) ->
    Segments = split_into_segments(S, K),
    lists:sum([count_complete_in_segment(Seg) || Seg <- Segments]).

split_into_segments(S, K) ->
    split_into_segments(S, K, [], []).

split_into_segments([], _K, CurrentSegment, Acc) ->
    case CurrentSegment of
        [] -> lists:reverse(Acc);
        _ -> lists:reverse([lists:reverse(CurrentSegment) | Acc])
    end;
split_into_segments([H|T], K, CurrentSegment, Acc) ->
    case CurrentSegment of
        [] -> split_into_segments(T, K, [H], Acc); % Start new segment with H
        [Prev|_] ->
            Diff = abs(H - Prev),
            if Diff =< K ->
                split_into_segments(T, K, [H|CurrentSegment], Acc); % Continue current segment
            true ->
                NewAcc = [lists:reverse(CurrentSegment) | Acc], % Finish current segment, add to Acc
                split_into_segments(T, K, [H], NewAcc) % Start new segment with H
            end
    end.

count_complete_in_segment(Segment) ->
    % Convert segment to binary for efficient O(1) random access by index
    SegmentBin = list_to_binary(Segment),
    lists:sum([count_complete_for_N_chars(SegmentBin, N) || N <- lists:seq(1, 26)]).

count_complete_for_N_chars(SegmentBin, N_chars) ->
    Len = byte_size(SegmentBin),
    count_complete_for_N_chars_loop(SegmentBin, N_chars, 0, 0, #{}, 0, Len).

count_complete_for_N_chars_loop(_SegmentBin, _N_chars, _I_ptr, J_ptr, _FreqMap, Count, Len) when J_ptr == Len ->
    Count;
count_complete_for_N_chars_loop(SegmentBin, N_chars, I_ptr, J_ptr, FreqMap, Count, Len) ->
    % Add CharJ (character at J_ptr) to the window
    CharJ = binary:at(SegmentBin, J_ptr),
    NewFreqMap1 = maps:update_with(CharJ, fun(V) -> V + 1 end, 1, FreqMap),

    % Shrink window from left if distinct character count exceeds N_chars
    {NewI_ptr, NewFreqMap2} = shrink_window_loop(SegmentBin, N_chars, I_ptr, NewFreqMap1),

    % Check if the current window [NewI_ptr ... J_ptr] forms a complete substring
    CurrentCount = 
        case maps:size(NewFreqMap2) of
            N_chars -> % Exactly N_chars distinct characters
                WindowLen = J_ptr - NewI_ptr + 1,
                if WindowLen rem N_chars == 0 -> % Length must be a multiple of N_chars
                    ExpectedFreq = WindowLen div N_chars,
                    % All characters must have the same frequency
                    IsComplete = lists:all(fun({_C, F}) -> F == ExpectedFreq end, maps:to_list(NewFreqMap2)),
                    if IsComplete -> Count + 1;
                    true -> Count
                    end;
                true -> Count
                end;
            _ -> Count % Not N_chars distinct characters, so not complete
        end,

    % Move to the next character (expand window to the right)
    count_complete_for_N_chars_loop(SegmentBin, N_chars, NewI_ptr, J_ptr + 1, NewFreqMap2, CurrentCount, Len).

shrink_window_loop(SegmentBin, N_chars, I_ptr, FreqMap) ->
    ShrinkLoop = fun ShrinkLoopFun(Idx, Map) ->
        if maps:size(Map) > N_chars -> % If distinct count is too high, shrink
            CharI = binary:at(SegmentBin, Idx), % Get char at Idx
            Val = maps:get(CharI, Map),
            NewMap = 
                if Val == 1 -> maps:remove(CharI, Map); % Remove if frequency becomes 0
                true -> maps:update(CharI, Val - 1, Map) % Decrement frequency
                end,
            ShrinkLoopFun(Idx + 1, NewMap); % Move left pointer
        true ->
            {Idx, Map} % Stop shrinking
        end
    end,

    ShrinkLoop(I_ptr, FreqMap).