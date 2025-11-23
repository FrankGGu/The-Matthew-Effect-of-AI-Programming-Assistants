-module(minimum_incompatibility).
-export([minimum_incompatibility/1]).

minimum_incompatibility(Nums) ->
    N = length(Nums),
    K = N div (N div 2),
    lists:sort(Nums),
    minimum_incompatibility(Nums, N, K, 0, []).

minimum_incompatibility(Nums, N, K, Mask, Memo) ->
    case Memo of
        [{Mask, Value} | _] ->
            Value;
        _ ->
            if Mask == (1 bsl N) - 1 then
                0
            else
                Result = find_min_incompatibility(Nums, N, K, Mask, Memo),
                [{Mask, Result} | Memo]
            end
    end.

find_min_incompatibility(Nums, N, K, Mask, Memo) ->
    FirstIndex = lists:seq(0, N - 1) -- [I || I <- lists:seq(0, N - 1), (Mask band (1 bsl I)) > 0],
    First = lists:nth(1, FirstIndex),
    SubList = get_sublist(Nums, FirstIndex, K),
    case SubList of
        [] ->
            infinity;
        _ ->
            lists:foldl(
                fun(Sub, Acc) ->
                    NewMask = lists:foldl(fun(Index, AccMask) -> AccMask bor (1 bsl Index) end, Mask, Sub),
                    Incompatibility = lists:max(Sub) - lists:min(Sub),
                    NextResult = minimum_incompatibility(Nums, N, K, NewMask, Memo),
                    min(Acc, Incompatibility + NextResult)
                end,
                infinity,
                SubList
            )
    end.

get_sublist(Nums, FirstIndex, K) ->
    get_sublist(Nums, FirstIndex, K, []).

get_sublist(_, [], _, Acc) ->
    Acc;
get_sublist(Nums, FirstIndex, K, Acc) ->
    SubList = get_k_indices(FirstIndex, K, []),
    FilteredSubList = [Sub || Sub <- SubList, is_valid(Nums, Sub)],
    Acc ++ FilteredSubList.

get_k_indices(FirstIndex, K, Acc) ->
    get_k_indices(FirstIndex, K, [], [], Acc).

get_k_indices(_, 0, Current, _, Acc) ->
    [Current | Acc];
get_k_indices([], _, _, _, Acc) ->
    Acc;
get_k_indices([H | T], K, Current, Used, Acc) ->
    if lists:member(H, Used) then
        get_k_indices(T, K, Current, Used, Acc)
    else
        get_k_indices(T, K - 1, [H | Current], [H | Used], get_k_indices(T, K, Current, Used, Acc))
    end.

is_valid(Nums, Indices) ->
    Values = [lists:nth(I + 1, Nums) || I <- lists:reverse(Indices)],
    length(Values) == length(lists:usort(Values)).

infinity ->
    16#7fffffff.