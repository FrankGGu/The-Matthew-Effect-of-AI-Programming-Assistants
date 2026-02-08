-module(degree_of_an_array).
-export([find_shortest_subarray/1]).

find_shortest_subarray(Nums) ->
    Map = lists:foldl(fun(N, Acc) ->
        case maps:is_key(N, Acc) of
            true ->
                {Count, First, Last} = maps:get(N, Acc),
                maps:put(N, {Count + 1, First, erlang:length(Nums) - 1}, Acc);
            false ->
                maps:put(N, {1, erlang:length(Nums) - 1, erlang:length(Nums) - 1}, Acc)
        end
    end, #{}, Nums),
    MaxCount = lists:max([Count || {Count, _, _} <- maps:values(Map)]),
    MinLength = lists:min([Last - First + 1 || {Count, First, Last} <- maps:values(Map), Count == MaxCount]),
    MinLength.