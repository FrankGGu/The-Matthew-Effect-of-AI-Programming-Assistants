-module(combinations).
-export([combine/2]).

combine(N, K) ->
    combine_helper(N, K, 1, []).

combine_helper(N, 0, _, Acc) ->
    [lists:reverse(Acc)];
combine_helper(N, K, I, Acc) when K > 0 ->
    case I > N of
        true ->
            [];
        false ->
            combine_helper(N, K - 1, I + 1, [I | Acc]) ++ combine_helper(N, K, I + 1, Acc)
    end.