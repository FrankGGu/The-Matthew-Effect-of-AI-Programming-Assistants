-module(solution).
-export([minimum_subarray_length/2]).

minimum_subarray_length(Nums, K) ->
    N = length(Nums),
    MinLen = infinity,
    Lists = lists:seq(0, N - 1),
    [process_list(Nums, K, I, MinLen) || I <- Lists],
    case MinLen of
        infinity -> -1;
        _ -> MinLen
    end.

process_list(_, _, _, MinLen) when MinLen == 0 -> ok;
process_list(Nums, K, Start, MinLen) ->
    Current = [],
    process_sublist(Nums, Start, Current, K, MinLen).

process_sublist(_, _, _, _, MinLen) when MinLen == 0 -> ok;
process_sublist(Nums, Start, Acc, K, MinLen) ->
    case Start >= length(Nums) of
        true -> ok;
        false ->
            NewAcc = lists:append(Acc, [lists:nth(Start + 1, Nums)]),
            OrVal = lists:foldl(fun(X, Acc2) -> Acc2 bor X end, 0, NewAcc),
            if
                OrVal >= K ->
                    Len = length(NewAcc),
                    if
                        Len < MinLen -> 
                            erlang:erase(min_len), 
                            erlang:put(min_len, Len);
                        true -> ok
                    end;
                true -> ok
            end,
            process_sublist(Nums, Start + 1, NewAcc, K, MinLen)
    end.