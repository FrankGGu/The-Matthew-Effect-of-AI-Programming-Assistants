-module(solution).
-export([find_array_concatenation_value/1]).

find_array_concatenation_value(Nums) ->
    find_array_concatenation_value(Nums, 0).

find_array_concatenation_value([], Acc) ->
    Acc;
find_array_concatenation_value([H], Acc) ->
    Acc + H;
find_array_concatenation_value(List, Acc) when is_list(List) ->
    First = hd(List),
    Last = lists:last(List),
    Remaining = tl(lists:droplast(List)),
    ConcatenatedVal = list_to_integer(integer_to_list(First) ++ integer_to_list(Last)),
    find_array_concatenation_value(Remaining, Acc + ConcatenatedVal).