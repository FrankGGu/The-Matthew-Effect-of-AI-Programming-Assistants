-spec split_array(Nums :: [integer()]) -> boolean().
split_array(Nums) ->
    case lists:sort(Nums) of
        Sorted ->
            check_pairs(Sorted)
    end.

check_pairs([]) -> true;
check_pairs([_]) -> false;
check_pairs([X, Y | Rest]) ->
    (X =:= Y) andalso check_pairs(Rest).