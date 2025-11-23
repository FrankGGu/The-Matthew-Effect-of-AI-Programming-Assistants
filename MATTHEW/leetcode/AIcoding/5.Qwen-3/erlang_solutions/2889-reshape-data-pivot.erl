-module(reshape_data_pivot).
-export([pivot_table/1]).

pivot_table(Data) ->
    Rows = lists:reverse(Data),
    Header = hd(Rows),
    Keys = lists:seq(1, length(Header)),
    Values = lists:tl(Rows),
    Map = maps:from_list(lists:zip(Keys, Header)),
    Pivot = lists:foldl(fun(Row, Acc) ->
        RowMap = maps:from_list(lists:zip(Keys, Row)),
        Key = maps:get(1, RowMap),
        Value = maps:get(2, RowMap),
        Type = maps:get(3, RowMap),
        case maps:find(Type, Acc) of
            {ok, V} -> maps:update(Type, [Key | V], Acc);
            error -> maps:put(Type, [Key], Acc)
        end
    end, #{}, Values),
    Pivoted = lists:sort([{Type, lists:reverse(V)} || {Type, V} <- maps:to_list(Pivot)]),
    [[<<"Category">>, <<"Row">>, <<"Value">>]] ++ 
    lists:map(fun({Type, Row}) ->
        lists:map(fun(RowKey) -> [RowKey, Type, lists:sum([Val || {K, Val} <- Row, K == RowKey])] end, maps:keys(Map))
    end, Pivoted).

sum_values_for_key([], _) -> 0;
sum_values_for_key([{Key, Val} | Rest], TargetKey) ->
    if Key == TargetKey -> Val + sum_values_for_key(Rest, TargetKey);
       true -> sum_values_for_key(Rest, TargetKey)
    end.