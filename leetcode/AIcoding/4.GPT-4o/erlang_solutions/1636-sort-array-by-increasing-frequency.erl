sortArrayByFrequency(A) ->
    FreqMap = lists:foldl(fun(X, Acc) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, fun() -> 1 end, Acc)
    end, maps:new(), A),
    FreqList = maps:to_list(FreqMap),
    Sorted = lists:sort(fun({Key1, Val1}, {Key2, Val2}) ->
        case Val1 < Val2 of
            true -> true;
            false -> case Val1 > Val2 of
                true -> false;
                false -> Key1 > Key2
            end
        end
    end, FreqList),
    lists:flatmap(fun({Key, _}) -> lists:duplicate(maps:get(Key, FreqMap), Key) end, Sorted).