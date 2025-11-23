-module(solution).
-export([max_chunks_to_sorted_ii/1]).

max_chunks_to_sorted_ii(Arr) ->
    N = length(Arr),
    case N of
        0 -> 0;
        1 -> 1;
        _ ->
            MaxLeft = calculate_max_left(Arr),
            MinRight = calculate_min_right(Arr),
            % Compare MaxLeft[i] with MinRight[i+1]
            % MaxLeft is [MaxL_0, MaxL_1, ..., MaxL_{N-1}]
            % MinRight is [MinR_0, MinR_1, ..., MinR_{N-1}]
            % We need to compare MaxL_i with MinR_{i+1} for i from 0 to N-2.
            % So, we iterate MaxLeft and tl(MinRight).
            count_chunks(MaxLeft, tl(MinRight), 1)
    end.

calculate_max_left([H|T]) ->
    max_left_acc(T, H, [H]).

max_left_acc([H|T], CurrentMax, Acc) ->
    NewMax = max(H, CurrentMax),
    max_left_acc(T, NewMax, [NewMax|Acc]);
max_left_acc([], _, Acc) ->
    lists:reverse(Acc).

calculate_min_right(Arr) ->
    % Compute min suffix array by iterating from right to left
    % This means reversing the list, computing min prefix, and the result is min suffix
    min_right_acc(lists:reverse(Arr), [], infinity).

min_right_acc([], Acc, _) ->
    Acc;
min_right_acc([H|T], Acc, CurrentMin) ->
    NewMin = min(H, CurrentMin),
    min_right_acc(T, [NewMin|Acc], NewMin).

count_chunks([_], [], Chunks) ->
    Chunks;
count_chunks([MaxL_H|MaxL_T], [MinR_H|MinR_T], Chunks) ->
    IfSplit = if MaxL_H =< MinR_H -> 1; true -> 0 end,
    count_chunks(MaxL_T, MinR_T, Chunks + IfSplit).