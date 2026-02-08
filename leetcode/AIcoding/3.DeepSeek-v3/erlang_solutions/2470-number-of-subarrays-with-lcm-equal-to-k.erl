-spec subarray_lcm(Nums :: [integer()], K :: integer()) -> integer().
subarray_lcm(Nums, K) ->
    Len = length(Nums),
    Count = 0,
    lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    Subarray = lists:sublist(Nums, I, J - I + 1),
                    case lcm_list(Subarray) of
                        K -> InnerAcc + 1;
                        _ -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(I, Len)
            )
        end,
        Count,
        lists:seq(1, Len)
    ).

lcm_list([]) -> 0;
lcm_list([H | T]) -> lists:foldl(fun(X, Acc) -> lcm(X, Acc) end, H, T).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A * B) div gcd(A, B).