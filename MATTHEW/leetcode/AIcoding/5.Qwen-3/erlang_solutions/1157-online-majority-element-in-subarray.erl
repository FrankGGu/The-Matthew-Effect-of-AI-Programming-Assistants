-module(OnlineMajorityElementInSubarray).
-export([__init__/0, query/3]).

__init__() ->
    {ok, []}.

query(Idx, Left, Right) ->
    {ok, Data} = erlang:process_info(self(), initial_call),
    [Arr] = lists:tl(Data),
    Count = count_majority(Arr, Left, Right),
    Count.

count_majority(Arr, Left, Right) ->
    Len = length(Arr),
    if
        Left < 0 orelse Right >= Len orelse Left > Right -> -1;
        true ->
            Sub = lists:sublist(Arr, Left + 1, Right - Left + 1),
            Majority = majority_element(Sub),
            Majority
    end.

majority_element(List) ->
    CountMap = maps:new(),
    Majority = find_majority(List, CountMap),
    Majority.

find_majority([], _) -> -1;
find_majority([H | T], Map) ->
    case maps:is_key(H, Map) of
        true ->
            NewMap = maps:update(H, maps:get(H, Map) + 1, Map),
            find_majority(T, NewMap);
        false ->
            NewMap = maps:put(H, 1, Map),
            find_majority(T, NewMap)
    end.

majority_element(List, CountMap) ->
    MaxCount = length(List) div 2 + 1,
    lists:foldl(
        fun(Elem, {Found, _}) ->
            case maps:get(Elem, CountMap, 0) of
                C when C >= MaxCount -> {Elem, true};
                _ -> {Found, false}
            end
        end,
        {-1, false},
        lists:reverse(lists:keys(CountMap))
    ).