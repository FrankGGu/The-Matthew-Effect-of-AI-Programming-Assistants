-module(concatenated_divisibility).
-export([can_be_divided_by_k/2]).

num_digits(0) -> 1;
num_digits(N) when N > 0 -> trunc(math:log10(N)) + 1.

precompute_powers_of_10(MaxL, K) ->
    lists:foldl(fun(L, Acc) ->
        PowerOf10 = if L == 0 -> 1;
                      true -> (lists:last(Acc) * 10) rem K
                    end,
        Acc ++ [PowerOf10]
    end, [], lists:seq(0, MaxL)).

can_be_divided_by_k(NumsList, K) ->
    N = length(NumsList),
    Nums = list_to_tuple(NumsList),

    MaxDigits = lists:foldl(fun(X, Acc) -> max(Acc, num_digits(X)) end, 0, NumsList),

    Pow10ModKList = precompute_powers_of_10(MaxDigits, K),
    Pow10ModK = list_to_tuple(Pow10ModKList),

    NumsModKList = lists:map(fun(X) -> X rem K end, NumsList),
    NumsModK = list_to_tuple(NumsModKList),

    InitialDP = array:new([{size, 1 bsl N}, {default, #{}}]),
    DP = array:set(0, #{0 => true}, InitialDP),

    FinalDP =
        lists:foldl(fun(Mask, CurrentDPTable) ->
            case array:get(Mask, CurrentDPTable) of
                #{} -> CurrentDPTable;
                RemMap ->
                    lists:foldl(fun({PrevRem, true}, AccDPTable) ->
                        lists:foldl(fun(I, InnerAccDPTable) ->
                            IfBitSet = Mask band (1 bsl I),
                            if IfBitSet == 0 ->
                                NumI = element(I + 1, Nums),
                                NumIDigits = num_digits(NumI),
                                NumIModK = element(I + 1, NumsModK),

                                Pow10LenIModK = element(NumIDigits + 1, Pow10ModK),
                                NewRem = ( (PrevRem * Pow10LenIModK) + NumIModK ) rem K,

                                NewMask = Mask bor (1 bsl I),
                                CurrentNewMaskRemMap = array:get(NewMask, InnerAccDPTable),
                                UpdatedNewMaskRemMap = maps:put(NewRem, true, CurrentNewMaskRemMap),
                                array:set(NewMask, UpdatedNewMaskRemMap, InnerAccDPTable)
                            end;
                            true -> InnerAccDPTable
                            end
                        end, AccDPTable, lists:seq(0, N - 1))
                    end, CurrentDPTable, maps:to_list(RemMap))
            end
        end, DP, lists:seq(0, (1 bsl N) - 1)),

    FinalMask = (1 bsl N) - 1,
    FinalRemMap = array:get(FinalMask, FinalDP),
    maps:is_key(0, FinalRemMap).