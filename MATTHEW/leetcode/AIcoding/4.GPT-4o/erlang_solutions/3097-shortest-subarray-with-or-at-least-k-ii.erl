-module(solution).
-export([shortest_subarray/2]).

shortest_subarray(A, K) ->
    N = length(A),
    Prefix = lists:foldl(fun(X, Acc) -> [X bor hd(Acc)] ++ Acc end, [0], lists:reverse(A)),
    shortest_subarray_helper(Prefix, K, N).

shortest_subarray_helper(Prefix, K, N) ->
    {MinLength, _} = lists:foldl(fun(X, {Min, Index}) ->
        case lists:find(fun(Y) -> Y >= K end, lists:sublist(Prefix, Index + 1)) of
            none -> {Min, Index + 1};
            {ok, SubIndex} ->
                Length = SubIndex - Index,
                Min1 = min(Min, Length),
                {Min1, Index + 1}
        end
    end, {N + 1, 0}, lists:seq(0, N - 1)),
    if MinLength > N -> -1; true -> MinLength end.