-module(solution).
-export([findLHS/1]).

findLHS(Nums) ->
    FreqMap = build_freq_map(Nums),
    Keys = maps:keys(FreqMap),
    lists:foldl(fun(N, MaxLen) ->
        case maps:find(N + 1, FreqMap) of
            {ok, FreqNPlus1} ->
                FreqN = maps:get(N, FreqMap),
                max(MaxLen, FreqN + FreqNPlus1);
            error ->
                MaxLen
        end
    end, 0, Keys).

build_freq_map(List) ->
    lists:foldl(fun(X, Map) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Map)
    end, maps:new(), List).