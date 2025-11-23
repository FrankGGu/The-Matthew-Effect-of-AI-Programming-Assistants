-module(solution).
-export([cross_river/1]).

cross_river(Stones) ->
    N = length(Stones),
    DP = maps:new(),
    DP1 = maps:put(0, 0, DP),
    DP2 = maps:put(1, 1, DP1),
    cross_river(Stones, 1, 1, DP2, N).

cross_river(Stones, Pos, K, DP, N) when Pos == N - 1 ->
    true;
cross_river(Stones, Pos, K, DP, N) ->
    case maps:is_key(Pos, DP) of
        false -> false;
        true ->
            PossibleKs = lists:usort([K - 1, K, K + 1]),
            ValidKs = lists:filter(fun(X) -> X > 0 end, PossibleKs),
            check_next(Stones, Pos, ValidKs, DP, N)
    end.

check_next(Stones, Pos, [], _DP, _N) ->
    false;
check_next(Stones, Pos, [K | Rest], DP, N) ->
    NextPos = Pos + K,
    case lists:keyfind(NextPos, 1, Stones) of
        false -> check_next(Stones, Pos, Rest, DP, N);
        {NextPos, _} ->
            case cross_river(Stones, NextPos, K, maps:put(NextPos, K, DP), N) of
                true -> true;
                false -> check_next(Stones, Pos, Rest, DP, N)
            end
    end.