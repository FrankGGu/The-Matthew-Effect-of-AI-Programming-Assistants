-module(solution).
-export([super_egg_drop/2]).

super_egg_drop(N, K) ->
    super_egg_drop(N, K, []).

super_egg_drop(0, K, _) ->
    0;
super_egg_drop(N, 0, _) ->
    0;
super_egg_drop(N, K, Memo) ->
    case lists:keyfind({N, K}, 1, Memo) of
        {_, Result} -> Result;
        false ->
            Result = min_drop(N, K, 1, K),
            super_egg_drop(N, K, [{N, K, Result} | Memo]),
            Result
    end.

min_drop(N, K, Low, High) ->
    case Low >= High of
        true -> Low;
        false ->
            Mid = (Low + High) div 2,
            Break = super_egg_drop(N - 1, Mid - 1),
            NotBreak = super_egg_drop(N, K - Mid),
            case Break > NotBreak of
                true -> min_drop(N, K, Low, Mid);
                false -> min_drop(N, K, Mid + 1, High)
            end
    end.