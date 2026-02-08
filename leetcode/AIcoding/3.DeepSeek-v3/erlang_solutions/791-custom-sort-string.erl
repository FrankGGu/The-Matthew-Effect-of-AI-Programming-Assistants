-spec custom_sort_string(Order :: unicode:unicode_binary(), Str :: unicode:unicode_binary()) -> unicode:unicode_binary().
custom_sort_string(Order, Str) ->
    OrderList = unicode:characters_to_list(Order),
    StrList = unicode:characters_to_list(Str),
    OrderMap = lists:foldl(fun(Char, Map) -> maps:put(Char, maps:size(Map), Map) end, #{}, OrderList),
    {InOrder, NotInOrder} = lists:partition(fun(Char) -> maps:is_key(Char, OrderMap) end, StrList),
    Sorted = lists:sort(fun(A, B) -> maps:get(A, OrderMap) < maps:get(B, OrderMap) end, InOrder),
    ResultList = Sorted ++ NotInOrder,
    unicode:characters_to_binary(ResultList).