-module(solution).
-export([min_operations/2]).

min_operations(A, B) ->
    B1 = lists:usort(B),
    A1 = lists:usort(A),
    {Count, _} = lists:foldl(fun(X, {Count, Y}) ->
        case lists:member(X, B1) of
            true -> {Count, Y - 1};
            false -> {Count + 1, Y}
        end
    end, {0, length(A1)}, A1),
    Count + lists:length(B1) - lists:length(lists:filter(fun(X) -> lists:member(X, A1) end, B1)).