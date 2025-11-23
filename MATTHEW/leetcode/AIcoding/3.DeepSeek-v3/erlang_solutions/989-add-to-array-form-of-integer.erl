-spec add_to_array_form(Nums :: [integer()], K :: integer()) -> [integer()].
add_to_array_form(Nums, K) ->
    add_to_array_form(Nums, K, []).

add_to_array_form([], 0, Acc) ->
    lists:reverse(Acc);
add_to_array_form([], K, Acc) ->
    add_to_array_form([], K div 10, [K rem 10 | Acc]);
add_to_array_form([N | Nums], K, Acc) ->
    Sum = N + K,
    add_to_array_form(Nums, Sum div 10, [Sum rem 10 | Acc]).