-module(minimum_incompatibility).
-export([minimum_incompatibility/2]).

minimum_incompatibility(Nums, K) ->
    N = length(Nums),
    {Min, _} = minimum_incompatibility(Nums, K, [], 0, 0, 0, 0, 1 bsl N - 1),
    if Min == 1 bsl 64 -> -1; true -> Min end.

minimum_incompatibility(_, 0, _, Min, Sum, _, Acc, _) when Sum == 0 ->
    {Min, Acc};
minimum_incompatibility(Nums, K, Used, Min, Sum, Cur, Acc, Max) when K > 0 ->
    lists:foldl(fun(X, {Min, Acc}) ->
        case lists:member(X, Used) of
            true -> {Min, Acc};
            false -> 
                NewUsed = [X | Used],
                NewSum = Sum + X,
                case is_incompatible(NewUsed) of
                    true -> 
                        if 
                            Cur + 1 == K -> 
                                NewMin = min(Min, NewSum),
                                {NewMin, NewSum}
                            ; 
                            true -> 
                                minimum_incompatibility(Nums, K - 1, [], min(Min, NewSum), 0, 0, Acc + 1, Max)
                        end
                    false -> {Min, Acc}
                end
        end
    end, {Min, Acc}, lists:sort(Nums).

is_incompatible(List) ->
    case lists:usort(List) of
        [] -> false;
        [_] -> false;
        [_ | T] -> not lists:all(fun(X) -> not lists:member(X, T) end, T)
    end.