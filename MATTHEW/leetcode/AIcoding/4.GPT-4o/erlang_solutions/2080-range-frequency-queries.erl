-module(range_frequency_queries).
-export([RangeFreqQuery/2, new/1, add/2, query/3]).

-record(query_struct, {data = [], freq_map = #{}}).

new(Data) ->
    FreqMap = maps:fold(fun(X, Acc) -> maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, Data),
    #query_struct{data = Data, freq_map = FreqMap}.

add(QueryStruct, Val) ->
    Data = QueryStruct#query_struct.data,
    NewData = lists:append(Data, [Val]),
    NewFreqMap = maps:update_with(Val, fun(Count) -> Count + 1 end, 1, QueryStruct#query_struct.freq_map),
    #query_struct{data = NewData, freq_map = NewFreqMap}.

query(QueryStruct, Left, Right) ->
    Data = QueryStruct#query_struct.data,
    FreqMap = QueryStruct#query_struct.freq_map,
    lists:foldl(fun(X, Acc) -> if X >= Left, X =< Right -> Acc + maps:get(X, FreqMap, 0); true -> Acc end end, 0, Data).

RangeFreqQuery(Data) ->
    NewStruct = new(Data),
    fun
        {add, Val} -> NewStruct = add(NewStruct, Val), NewStruct;
        {query, Left, Right} -> query(NewStruct, Left, Right)
    end.