-spec is_array_special(Nums :: [integer()]) -> boolean().
is_array_special(Nums) ->
    is_special(Nums).

is_special([_]) -> true;
is_special([X, Y | Rest]) ->
    case (X rem 2) =:= (Y rem 2) of
        true -> false;
        false -> is_special([Y | Rest])
    end.