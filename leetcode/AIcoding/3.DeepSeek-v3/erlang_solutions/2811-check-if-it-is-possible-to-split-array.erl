-spec can_split_array(Nums :: [integer()], M :: integer()) -> boolean().
can_split_array(Nums, M) ->
    case length(Nums) =< 2 of
        true -> true;
        false ->
            lists:any(fun({A, B}) -> A + B >= M end, lists:zip(Nums, tl(Nums)))
    end.