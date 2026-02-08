-spec can_partition_k_subsets(Nums :: [integer()], K :: integer()) -> boolean().
can_partition_k_subsets(Nums, K) ->
    Total = lists:sum(Nums),
    case Total rem K of
        0 ->
            Target = Total div K,
            Sorted = lists:sort(fun(A, B) -> A > B end, Nums),
            case Sorted of
                [H|_] when H > Target -> false;
                _ ->
                    Used = array:new(length(Sorted), {default, false}),
                    backtrack(Sorted, Used, 0, 0, K, Target)
            end;
        _ -> false
    end.

backtrack(_, _, _, _, 0, _) -> true;
backtrack(Nums, Used, Start, CurrentSum, K, Target) ->
    case CurrentSum =:= Target of
        true ->
            backtrack(Nums, Used, 0, 0, K - 1, Target);
        false ->
            lists:any(fun(I) ->
                case array:get(I, Used) of
                    false ->
                        Num = lists:nth(I + 1, Nums),
                        case CurrentSum + Num =< Target of
                            true ->
                                NewUsed = array:set(I, true, Used),
                                case backtrack(Nums, NewUsed, I + 1, CurrentSum + Num, K, Target) of
                                    true -> true;
                                    false ->
                                        backtrack(Nums, Used, I + 1, CurrentSum, K, Target)
                                end;
                            false -> false
                        end;
                    true -> false
                end
            end, lists:seq(Start, length(Nums) - 1))
    end.