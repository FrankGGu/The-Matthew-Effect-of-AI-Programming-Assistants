-spec k_length_apart(Nums :: [integer()], K :: integer()) -> boolean().
k_length_apart(Nums, K) ->
    k_length_apart(Nums, K, -1).

k_length_apart([], _, _) -> true;
k_length_apart([1 | Rest], K, LastPos) when LastPos >= 0 ->
    case length(Rest) + 1 - LastPos - 1 >= K of
        true -> k_length_apart(Rest, K, length(Rest) + 1);
        false -> false
    end;
k_length_apart([1 | Rest], K, _) ->
    k_length_apart(Rest, K, length(Rest) + 1);
k_length_apart([_ | Rest], K, LastPos) ->
    k_length_apart(Rest, K, LastPos).