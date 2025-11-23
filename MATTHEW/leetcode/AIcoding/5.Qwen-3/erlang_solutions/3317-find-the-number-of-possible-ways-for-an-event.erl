-module(solution).
-export([num_ways/2]).

num_ways(questions, k) ->
    num_ways(questions, k, 0, 1, #{}).

num_ways([], _, _, Acc, _) ->
    Acc;
num_ways([Q | T], K, Index, Acc, Map) ->
    {A, B} = Q,
    Key = {Index, A, B},
    case maps:is_key(Key, Map) of
        true ->
            num_ways(T, K, Index + 1, Acc, Map);
        false ->
            Max = min(A, B),
            Count = 0,
            NewMap = maps:put(Key, Count, Map),
            num_ways(T, K, Index + 1, Acc, NewMap)
    end.