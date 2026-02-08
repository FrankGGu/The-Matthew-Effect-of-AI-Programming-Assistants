-module(max_dot_product).
-export([max_dot_product/2]).

max_dot_product(Nums1, Nums2) ->
    N1 = length(Nums1),
    N2 = length(Nums2),
    DP = array:new([N1 + 1, N2 + 1], {fixed, -infinity}),
    array:set(0, 0, 0, DP),
    max_dot_product_helper(Nums1, Nums2, N1, N2, DP).

max_dot_product_helper(Nums1, Nums2, I, J, DP) ->
    case array:get(I, J, DP) of
        -infinity ->
            Num1 = lists:nth(I, Nums1),
            Num2 = lists:nth(J, Nums2),

            Prev1 = max_dot_product_helper(Nums1, Nums2, I - 1, J, DP);
            Prev2 = max_dot_product_helper(Nums1, Nums2, I, J - 1, DP);
            Prev3 = max_dot_product_helper(Nums1, Nums2, I - 1, J - 1, DP);

            Value = max([Num1 * Num2, Num1 * Num2 + Prev3, Prev1, Prev2]);
            array:set(I, J, Value, DP),
            Value;
        Value ->
            Value
    end.

max(L) ->
    max_helper(L, hd(L)).

max_helper([], Acc) ->
    Acc;
max_helper([H | T], Acc) ->
    NewAcc = if H > Acc -> H; true -> Acc end,
    max_helper(T, NewAcc).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

max_dot_product_test() ->
    [?assertEqual(21, max_dot_product([2,1,-2,5], [3,0,-6])),
     ?assertEqual(18, max_dot_product([3,-2], [2,-6,7])),
     ?assertEqual(-1, max_dot_product([-1,-1], [1,1]))].

-endif.