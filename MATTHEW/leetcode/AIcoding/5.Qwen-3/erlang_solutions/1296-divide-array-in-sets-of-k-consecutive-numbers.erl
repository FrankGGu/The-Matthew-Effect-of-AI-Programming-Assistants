-module(solution).
-export([k_consecutive_cards/2]).

k_consecutive_cards(Nums, K) ->
    Count = maps:from_list([{N, 1} || N <- Nums]),
    Sorted = lists:sort(Nums),
    k_consecutive_cards(Sorted, Count, K).

k_consecutive_cards([], _, _) ->
    true;
k_consecutive_cards([N | Rest], Count, K) ->
    case maps:get(N, Count, 0) of
        0 ->
            k_consecutive_cards(Rest, Count, K);
        _ ->
            case check_and_remove(N, K, Count) of
                true ->
                    k_consecutive_cards(Rest, Count, K);
                false ->
                    false
            end
    end.

check_and_remove(_, 0, _) ->
    true;
check_and_remove(N, K, Count) ->
    case maps:get(N, Count, 0) of
        0 ->
            false;
        V ->
            NewCount = maps:update(N, V - 1, Count),
            check_and_remove(N + 1, K - 1, NewCount)
    end.