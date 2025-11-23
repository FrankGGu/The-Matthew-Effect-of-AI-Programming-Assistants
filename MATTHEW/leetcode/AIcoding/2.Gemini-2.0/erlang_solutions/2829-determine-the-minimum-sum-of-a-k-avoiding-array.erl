-module(min_sum_k_avoiding).
-export([min_sum/2]).

min_sum(N, K) ->
    min_sum_helper(N, K, 1, 0, []).

min_sum_helper(0, _, _, Sum, _) ->
    Sum;
min_sum_helper(N, K, Curr, Sum, Used) ->
    case lists:member(Curr, Used) of
        true ->
            min_sum_helper(N, K, Curr + 1, Sum, Used);
        false ->
            case Curr + K =< 2 * K orelse lists:member(K - Curr, Used) of
                true ->
                    min_sum_helper(N, K, Curr + 1, Sum, Used);
                false ->
                    min_sum_helper(N - 1, K, Curr + 1, Sum + Curr, [Curr|Used])
            end
    end.