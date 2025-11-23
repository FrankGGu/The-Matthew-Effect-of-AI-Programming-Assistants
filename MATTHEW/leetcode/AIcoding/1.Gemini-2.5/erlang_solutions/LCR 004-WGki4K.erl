-module(solution).
-export([single_number/1]).

single_number(Nums) ->
    single_number_bits(Nums, 0, 0).

single_number_bits(Nums, BitIdx, AccResult) when BitIdx < 32 ->
    SumBits = count_bit_at_pos(Nums, BitIdx),
    NewAccResult =
        case (SumBits rem 3) of
            1 -> AccResult bor (1 bsl BitIdx);
            _ -> AccResult
        end,
    single_number_bits(Nums, BitIdx + 1, NewAccResult);
single_number_bits(_Nums, _BitIdx, AccResult) ->
    AccResult.

count_bit_at_pos(Nums, BitIdx) ->
    lists:foldl(fun(N, Acc) ->
                    case (N band (1 bsl BitIdx)) of
                        0 -> Acc;
                        _ -> Acc + 1
                    end
                end, 0, Nums).