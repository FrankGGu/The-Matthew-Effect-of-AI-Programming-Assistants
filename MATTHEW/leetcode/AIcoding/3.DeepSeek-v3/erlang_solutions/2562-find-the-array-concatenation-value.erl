-spec find_array_conc_val(Nums :: [integer()]) -> integer().
find_array_conc_val(Nums) ->
    find_array_conc_val(Nums, 0).

find_array_conc_val([], Acc) -> Acc;
find_array_conc_val([Num], Acc) -> Acc + Num;
find_array_conc_val([First | Rest], Acc) ->
    Last = lists:last(Rest),
    NewRest = lists:droplast(Rest),
    Concatenated = list_to_integer(integer_to_list(First) ++ integer_to_list(Last)),
    find_array_conc_val(NewRest, Acc + Concatenated).