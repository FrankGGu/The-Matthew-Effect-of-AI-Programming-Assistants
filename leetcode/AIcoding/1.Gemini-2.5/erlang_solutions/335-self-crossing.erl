-module(solution).
-export([is_self_crossing/1]).

is_self_crossing(Distances) ->
    % The 'Prev' list stores the last 5 distances in reverse order of recency:
    % [d_{i-1}, d_{i-2}, d_{i-3}, d_{i-4}, d_{i-5}]
    % We initialize it with 0s. Since all distances are positive, 0 acts as a sentinel
    % to indicate that a segment does not yet exist (i.e., the path is not long enough).
    check(Distances, [0,0,0,0,0]).

check([], _Prev) -> false; % No more distances, no crossing found.
check([X_i | Rest], [X_i_1, X_i_2, X_i_3, X_i_4, X_i_5] = _Prev) ->
    % Condition 1: The current segment (X_i) crosses the segment 3 steps ago (X_i_3).
    % This requires at least 4 segments to have been drawn (X_i, X_i_1, X_i_2, X_i_3).
    % X_i_3 > 0 ensures that d_{i-3} exists.
    if
        X_i_3 > 0 andalso X_i >= X_i_2 andalso X_i_1 <= X_i_3 -> true;
        true ->
            % Condition 2: The current segment (X_i) crosses the segment 4 steps ago (X_i_4).
            % This requires at least 5 segments (X_i, ..., X_i_4).
            % X_i_4 > 0 ensures that d_{i-4} exists.
            if
                X_i_4 > 0 andalso X_i_1 == X_i_3 andalso X_i + X_i_4 >= X_i_2 -> true;
                true ->
                    % Condition 3: The current segment (X_i) crosses the segment 5 steps ago (X_i_5).
                    % This requires at least 6 segments (X_i, ..., X_i_5).
                    % X_i_5 > 0 ensures that d_{i-5} exists.
                    if
                        X_i_5 > 0 andalso X_i_2 >= X_i_4 andalso X_i_3 >= X_i_5 andalso X_i + X_i_4 >= X_i_2 andalso X_i_1 + X_i_5 >= X_i_3 -> true;
                        true ->
                            % If no crossing is found in this iteration,
                            % update the 'Prev' list for the next iteration (sliding window).
                            % The new 'Prev' list will be [X_i, X_i_1, X_i_2, X_i_3, X_i_4].
                            check(Rest, [X_i, X_i_1, X_i_2, X_i_3, X_i_4])
                    end
            end
    end.