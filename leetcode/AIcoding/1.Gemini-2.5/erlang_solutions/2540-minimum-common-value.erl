-module(solution).
-export([min_common_value/2]).

min_common_value(Nums1, Nums2) ->
    min_common_value_recursive(Nums1, Nums2).

min_common_value_recursive([], _Nums2) -> -1;
min_common_value_recursive(_Nums1, []) -> -1;
min_common_value_recursive([H1|T1], [H2|T2]) ->
    if
        H1 == H2 -> H1;
        H1 < H2 -> min_common_value_recursive(T1, [H2|T2]);
        H1 > H2 -> min_common_value_recursive([H1|T1], T2)
    end.