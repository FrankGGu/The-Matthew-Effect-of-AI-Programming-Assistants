-module(solution).
-export([maximum_score_of_spliced_array/2]).

maximum_score_of_spliced_array(Nums1, Nums2) ->
    S1 = lists:sum(Nums1),
    S2 = lists:sum(Nums2),

    Diff1 = lists:zipwith(fun(N2, N1) -> N2 - N1 end, Nums2, Nums1),
    Diff2 = lists:zipwith(fun(N1, N2) -> N1 - N2 end, Nums1, Nums2),

    MaxSpliceGain1 = kadane(Diff1),
    MaxSpliceGain2 = kadane(Diff2),

    math:max(S1 + MaxSpliceGain1, S2 + MaxSpliceGain2).

kadane(List) ->
    kadane_impl(List, 0, 0).

kadane_impl([], MaxSoFar, _CurrentMax) ->
    MaxSoFar;
kadane_impl([H | T], MaxSoFar, CurrentMax) ->
    NewCurrentMax = math:max(CurrentMax + H, 0),
    NewMaxSoFar = math:max(MaxSoFar, NewCurrentMax),
    kadane_impl(T, NewMaxSoFar, NewCurrentMax).