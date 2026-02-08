-module(longest_ideal_subsequence).
-export([longest_ideal_subsequence/2]).

longest_ideal_subsequence(S, K) ->
    lists:foldl(fun(Char, {Max, Map}) ->
        Current = maps:get(Char, Map, 0),
        Prev = maps:get(<<(Char - K):8>>, Map, 0),
        NewCurrent = max(Current, Prev + 1),
        NewMap = maps:put(Char, NewCurrent, Map),
        {max(Max, NewCurrent), NewMap}
    end, {0, #{},}, S).