-module(solution).
-export([rangeSum/4]).

rangeSum(Nums, _N, Left, Right) ->
    Mod = 1000000007,

    SubarraySums = generate_all_subarray_sums(Nums),

    SortedSubarraySums = lists:sort(SubarraySums),

    TargetSublist = lists:sublist(SortedSubarraySums, Left, Right - Left + 1),

    lists:foldl(fun(X, Acc) -> (Acc + X) rem Mod end, 0, TargetSublist).

generate_all_subarray_sums(Nums) ->
    generate_all_subarray_sums(Nums, []).

generate_all_subarray_sums([], Acc) ->
    Acc;
generate_all_subarray_sums([H|T], Acc) ->
    NewAcc = generate_sums_from_start([H|T], 0, Acc),
    generate_all_subarray_sums(T, NewAcc).

generate_sums_from_start([], _CurrentSum, Acc) ->
    Acc;
generate_sums_from_start([H|T], CurrentSum, Acc) ->
    NewCurrentSum = CurrentSum + H,
    generate_sums_from_start(T, NewCurrentSum, [NewCurrentSum | Acc]).