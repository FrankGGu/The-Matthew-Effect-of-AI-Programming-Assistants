-module(solution).
-export([new/0, add/3, count/1]).

new() ->
    [].

add(Left, Right, Intervals) ->
    add_interval(Left, Right, Intervals, []).

add_interval(NewL, NewR, [], Acc) ->
    % No more existing intervals, add the merged interval to the accumulated ones.
    % Acc is built in reverse, so reverse it back and add the new interval.
    lists:reverse(Acc, [{NewL, NewR}]);
add_interval(NewL, NewR, [{CurL, CurR} | Rest], Acc) ->
    % Case 1: Current interval is completely before the new/merged interval
    % [CurL, CurR] ... [NewL, NewR]
    % This means CurR < NewL
    if
        CurR < NewL ->
            % Add current interval to accumulator and continue with the rest
            add_interval(NewL, NewR, Rest, [{CurL, CurR} | Acc]);
        % Case 2: Current interval is completely after the new/merged interval
        % [NewL, NewR] ... [CurL, CurR]
        % This means CurL > NewR
        CurL > NewR ->
            % The new/merged interval is now finalized.
            % Reverse accumulated intervals, add the finalized new interval, then the current, then the rest.
            lists:reverse(Acc, [{NewL, NewR}, {CurL, CurR} | Rest]);
        % Case 3: Current interval overlaps with the new/merged interval
        % This means CurR >= NewL and CurL <= NewR
        true -> % Overlap
            % Merge the current interval with the new/merged interval
            MergedL = min(CurL, NewL),
            MergedR = max(CurR, NewR),
            % Continue processing with the merged interval and the rest of the list
            add_interval(MergedL, MergedR, Rest, Acc)
    end.

count(Intervals) ->
    lists:foldl(fun({L, R}, Acc) -> Acc + (R - L + 1) end, 0, Intervals).