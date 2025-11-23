-module(solution).
-export([max_non_decreasing_length/1]).

max_non_decreasing_length(Nums) ->
    max_non_decreasing_length(Nums, 0, 0, 0).

max_non_decreasing_length([], _LastSum, CurrentLength, Ans) ->
    erlang:max(CurrentLength, Ans);
max_non_decreasing_length([H|T], LastSum, CurrentLength, Ans) ->
    case H >= LastSum of
        true ->
            % Start a new segment with H
            % The current non-decreasing array length increases by 1
            % Update LastSum to H
            max_non_decreasing_length(T, H, CurrentLength + 1, erlang:max(Ans, CurrentLength + 1));
        false ->
            % Merge H into the LastSum
            % The current non-decreasing array length remains the same
            % Update LastSum to LastSum + H
            max_non_decreasing_length(T, LastSum + H, CurrentLength, Ans)
    end.