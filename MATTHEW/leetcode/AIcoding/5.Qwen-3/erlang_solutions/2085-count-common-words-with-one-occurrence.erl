-module(solution).
-export([common_words/2]).

common_words(Words1, Words2) ->
    Count = fun(List) ->
        maps:fold(fun(K, V, Acc) -> maps:update_with(K, fun(X) -> X + 1 end, 1, Acc) end, #{}, List)
    end,
    Map1 = Count(Words1),
    Map2 = Count(Words2),
    Maps = [Map1, Map2],
    Common = maps:keys(maps:filter(fun(K, _) -> lists:all(fun(M) -> maps:is_key(K, M) andalso maps:get(K, M) == 1 end, Maps) end, Map1)),
    length(Common).