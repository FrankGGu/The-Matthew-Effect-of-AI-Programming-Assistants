-module(soup_servings).
-export([soupServings/1]).

soupServings(N) ->
    Cache = ets:new(cache, [set, public, {write_concurrency, true}]),
    Result = dfs(0, 0, N, Cache),
    ets:delete(Cache),
    Result.

dfs(A, B, N, Cache) ->
    case ets:lookup(Cache, {A, B}) of
        [{_, V}] -> V;
        [] ->
            if
                A >= N andalso B >= N -> 0.5;
                A >= N -> 1.0;
                B >= N -> 0.0;
                true ->
                    Res = 0.25 * (dfs(A + 1, B, N, Cache) + dfs(A + 2, B, N, Cache) + dfs(A, B + 1, N, Cache) + dfs(A, B + 2, N, Cache)),
                    ets:insert(Cache, {{A, B}, Res}),
                    Res
            end
    end.