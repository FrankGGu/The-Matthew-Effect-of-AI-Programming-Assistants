-spec remove_element(Nums :: [integer()], Val :: integer()) -> integer().
remove_element(Nums, Val) ->
    remove_element(Nums, Val, []).

remove_element([], _, Acc) ->
    length(Acc);
remove_element([H | T], Val, Acc) ->
    case H =:= Val of
        true -> remove_element(T, Val, Acc);
        false -> remove_element(T, Val, [H | Acc])
    end.