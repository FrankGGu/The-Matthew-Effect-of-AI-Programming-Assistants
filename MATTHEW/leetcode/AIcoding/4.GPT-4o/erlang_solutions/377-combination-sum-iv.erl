-spec combination_sum4(Nums :: [integer()], Target :: integer()) -> integer().
combination_sum4(Nums, Target) ->
    combination_sum4(Nums, Target, []).

combination_sum4(_, 0, Acc) -> 
    length(Acc);
combination_sum4(Nums, Target, Acc) when Target > 0 ->
    lists:foldl(fun(N, Acc2) -> 
        case Target - N >= 0 of
            true -> combination_sum4(Nums, Target - N, [1 | Acc2]);
            false -> Acc2
        end
    end, Acc, Nums);
combination_sum4(_, _, _) -> 0.
