-spec count_incremovable_subarrays(Nums :: [integer()]) -> integer().
count_incremovable_subarrays(Nums) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            [H|_] when X > H -> [X|Acc];
            _ -> Acc
        end
    end, [], Nums),
    LP = length(Prefix),
    Suffix = lists:foldr(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            [H|_] when X < H -> [X|Acc];
            _ -> Acc
        end
    end, [], Nums),
    LS = length(Suffix),
    if
        LP == N -> (N * (N + 1)) div 2;
        true ->
            Res = LP + LS + 1,
            I = LP,
            J = N - LS - 1,
            lists:foldl(fun(K, Sum) ->
                L = lists:nth(K + 1, Nums),
                case lists:nth(I + 1, Prefix) < L of
                    true -> Sum + (N - J);
                    false -> Sum
                end
            end, Res, lists:seq(I, J))
    end.