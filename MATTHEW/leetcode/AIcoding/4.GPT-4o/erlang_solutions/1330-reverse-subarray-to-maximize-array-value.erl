-module(solution).
-export([reverse_subarray/1]).

reverse_subarray(A) ->
    N = length(A),
    Max = lists:max(A),
    {Start, End} = find_reverse_subarray(A, N, Max),
    A1 = lists:sublist(A, 1, Start - 1) ++ lists:reverse(lists:sublist(A, Start, End - Start + 1)) ++ lists:sublist(A, End + 1, N - End),
    if
        lists:max(A1) > Max -> A1;
        true -> A
    end.

find_reverse_subarray(A, N, Max) ->
    find_bounds(A, N, Max, 0, 0).

find_bounds(A, N, Max, Start, End) ->
    case lists:foldl(fun(X, {S, E}) ->
            case {S, E} of
                {0, 0} when X < Max -> {1, 1};
                {S, E} when X < Max -> {S, E + 1};
                {S, E} when E > 0 -> {S, E};
                _ -> {S, E}
            end
        end, {Start, End}, A) of
        {0, 0} -> {1, 1}; % Default to first element if no valid subarray found
        Result -> Result
    end.