-module(replace_elements_in_an_array).
-export([remove_elements/1]).

remove_elements(Nums) ->
    Len = length(Nums),
    replace(Nums, Len, 0, []).

replace([], _, _, Acc) ->
    lists:reverse(Acc);
replace([H | T], Len, I, Acc) ->
    Next = if
               I == Len - 1 -> -1;
               true -> lists:nth(I + 2, Nums)
           end,
    replace(T, Len, I + 1, [Next | Acc]).