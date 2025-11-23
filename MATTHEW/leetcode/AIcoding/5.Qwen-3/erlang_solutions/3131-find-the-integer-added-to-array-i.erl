-module(solution).
-export([added_integer/2]).

added_integer( nums1, nums2 ) ->
    A = lists:foldl( fun(X, Acc) -> X + Acc end, 0, nums1 ),
    B = lists:foldl( fun(X, Acc) -> X + Acc end, 0, nums2 ),
    B - A.