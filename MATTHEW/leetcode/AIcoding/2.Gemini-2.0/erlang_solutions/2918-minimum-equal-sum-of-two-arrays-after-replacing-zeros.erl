-module(minimum_equal_sum).
-export([min_impossible_sum/2]).

min_impossible_sum(Nums1, Nums2) ->
    {Sum1, Zeros1} = sum_and_zeros(Nums1),
    {Sum2, Zeros2} = sum_and_zeros(Nums2),

    case Zeros1 == 0 andalso Zeros2 == 0 of
        true ->
            case Sum1 == Sum2 of
                true -> Sum1;
                false -> -1
            end;
        false ->
            case Sum1 + Zeros1 > Sum2 andalso Sum2 + Zeros2 > Sum1 of
                true -> max(Sum1 + Zeros1, Sum2 + Zeros2);
                false -> -1
            end
    end.

sum_and_zeros(List) ->
    sum_and_zeros_helper(List, 0, 0).

sum_and_zeros_helper([], Sum, Zeros) ->
    {Sum, Zeros};
sum_and_zeros_helper([H|T], Sum, Zeros) ->
    case H of
        0 ->
            sum_and_zeros_helper(T, Sum, Zeros + 1);
        _ ->
            sum_and_zeros_helper(T, Sum + H, Zeros)
    end.