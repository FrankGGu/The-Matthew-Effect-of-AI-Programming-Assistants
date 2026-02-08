-module(time_map).
-export([new/0, set/4, get/3]).

new() ->
    #{}.

set(TimeMap, Key, Value, Timestamp) ->
    case maps:find(Key, TimeMap) of
        {ok, List} ->
            NewList = insert_sorted(List, {Timestamp, Value}),
            maps:put(Key, NewList, TimeMap);
        error ->
            maps:put(Key, [{Timestamp, Value}], TimeMap)
    end.

get(TimeMap, Key, Timestamp) ->
    case maps:find(Key, TimeMap) of
        {ok, List} ->
            case binary_search(List, Timestamp) of
                {found, {_, Value}} ->
                    Value;
                {not_found, 0} ->
                    "";
                {not_found, Index} ->
                    {_, Value} = lists:nth(Index, List),
                    Value
            end;
        error ->
            ""
    end.

insert_sorted(List, {Timestamp, Value}) ->
    insert_sorted(List, {Timestamp, Value}, []).

insert_sorted([], {Timestamp, Value}, Acc) ->
    lists:reverse([{Timestamp, Value} | Acc]);
insert_sorted([{T, _} = Head | Tail], {Timestamp, Value}, Acc) when T > Timestamp ->
    lists:reverse([{Timestamp, Value} | Acc]) ++ [Head | Tail];
insert_sorted([Head | Tail], {Timestamp, Value}, Acc) ->
    insert_sorted(Tail, {Timestamp, Value}, [Head | Acc]).

binary_search(List, Timestamp) ->
    binary_search(List, Timestamp, 1, length(List)).

binary_search(_List, _Timestamp, Low, High) when Low > High ->
    {not_found, High};
binary_search(List, Timestamp, Low, High) ->
    Mid = (Low + High) div 2,
    {MidTimestamp, _} = lists:nth(Mid, List),
    if
        MidTimestamp =:= Timestamp ->
            {found, lists:nth(Mid, List)};
        MidTimestamp < Timestamp ->
            binary_search(List, Timestamp, Mid + 1, High);
        true ->
            binary_search(List, Timestamp, Low, Mid - 1)
    end.