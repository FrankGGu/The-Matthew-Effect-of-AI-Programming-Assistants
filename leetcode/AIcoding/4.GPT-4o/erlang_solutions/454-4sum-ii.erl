-module(solution).
-export([four_sum_count/4]).

%% Calculate the number of tuples (i, j, k, l) such that:
%% nums1[i] + nums2[j] + nums3[k] + nums4[l] == 0
-spec four_sum_count([integer()], [integer()], [integer()], [integer()]) -> integer().
four_sum_count(Nums1, Nums2, Nums3, Nums4) ->
    %% Create a hashmap of all sums of pairs from Nums1 and Nums2.
    SumMap1 = create_sum_map(Nums1, Nums2),
    %% Count the number of valid tuples using sums from Nums3 and Nums4.
    lists:foldl(fun(X, Acc) -> Acc + maps:get(-X, SumMap1, 0) end, 0, Nums3 ++ Nums4).

%% Helper function to create a sum map from two lists.
-spec create_sum_map([integer()], [integer()]) -> map().
create_sum_map([], []) -> #{};
create_sum_map([H1|T1], [H2|T2]) ->
    SumMap = create_sum_map(T1, T2),
    Sum = H1 + H2,
    maps:update_with(Sum, fun(X) -> X + 1 end, 1, SumMap).
