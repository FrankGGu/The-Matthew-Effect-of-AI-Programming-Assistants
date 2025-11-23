-module(maximum_erasure_value).
-export([maximum_erasure_value/1]).

maximum_erasure_value(Nums) ->
    erlang:apply(fun() -> 
        Map = maps:new(),
        Max = 0,
        Left = 0,
        {Max, _} = lists:foldl(fun({Val, Index}, {CurrentMax, Last}) ->
            case maps:is_key(Val, Map) of
                true ->
                    Prev = maps:get(Val, Map),
                    NewLeft = max(Left, Prev + 1),
                    NewMap = maps:put(Val, Index, Map),
                    CurrentSum = lists:sum(lists:sublist(Nums, NewLeft, Index - NewLeft + 1)),
                    NewMax = max(CurrentMax, CurrentSum),
                    {NewMax, NewMap};
                false ->
                    NewMap = maps:put(Val, Index, Map),
                    CurrentSum = lists:sum(lists:sublist(Nums, Left, Index - Left + 1)),
                    NewMax = max(CurrentMax, CurrentSum),
                    {NewMax, NewMap}
            end
        end, {Max, Map}, lists:zip(Nums, lists:seq(0, length(Nums) - 1))).
    end).