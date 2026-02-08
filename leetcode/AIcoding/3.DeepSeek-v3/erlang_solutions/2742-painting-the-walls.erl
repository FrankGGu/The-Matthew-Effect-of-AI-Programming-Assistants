-module(solution).
-export([paint_walls/2]).

paint_walls(Cost, Time) ->
    N = length(Cost),
    DP = maps:new(),
    DP1 = maps:put(0, 0, DP),
    solve(Cost, Time, 0, N, DP1).

solve(_, _, Index, N, DP) when Index >= N ->
    maps:get(0, DP);
solve(Cost, Time, Index, N, DP) ->
    C = lists:nth(Index + 1, Cost),
    T = lists:nth(Index + 1, Time),
    NewDP = maps:fold(fun(K, V, Acc) ->
        K1 = K + T + 1,
        case maps:is_key(K1, Acc) of
            true ->
                case maps:get(K1, Acc) > V + C of
                    true -> maps:put(K1, V + C, Acc);
                    false -> Acc
                end;
            false -> maps:put(K1, V + C, Acc)
        end,
        case maps:is_key(K, Acc) of
            true ->
                case maps:get(K, Acc) > V of
                    true -> maps:put(K, V, Acc);
                    false -> Acc
                end;
            false -> maps:put(K, V, Acc)
        end
    end, DP, DP),
    solve(Cost, Time, Index + 1, N, NewDP).