-spec sum_of_beauties(Nums :: [integer()]) -> integer().
sum_of_beauties(Nums) ->
    N = length(Nums),
    LeftMax = lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            _ -> [max(X, hd(Acc)) | Acc]
        end
    end, [], Nums),
    RightMin = lists:foldr(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            _ -> [min(X, hd(Acc)) | Acc]
        end
    end, [], Nums),
    lists:foldl(fun(I, Sum) ->
        if
            I > 1, I < N ->
                V = lists:nth(I, Nums),
                Left = lists:nth(I - 1, LeftMax),
                Right = lists:nth(I + 1, RightMin),
                if
                    Left < V, V < Right -> Sum + 2;
                    lists:nth(I - 1, Nums) < V, V < lists:nth(I + 1, Nums) -> Sum + 1;
                    true -> Sum
                end;
            true -> Sum
        end
    end, 0, lists:seq(1, N)).