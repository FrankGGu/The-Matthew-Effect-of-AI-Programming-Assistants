-module(solution).
-export([splitArray/2]).

splitArray(Nums, M) ->
    MaxNum = lists:max(Nums),
    SumNums = lists:sum(Nums),

    Low = MaxNum,
    High = SumNums,

    binary_search(Low, High, Nums, M, High).

binary_search(Low, High, Nums, M, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    if
        can_split(Mid, Nums, M) ->
            binary_search(Low, Mid - 1, Nums, M, Mid);
        true ->
            binary_search(Mid + 1, High, Nums, M, Ans)
    end;
binary_search(_Low, _High, _Nums, _M, Ans) ->
    Ans.

can_split(MaxSum, Nums, M) ->
    can_split_impl(Nums, MaxSum, M, 1, 0).

can_split_impl([], _MaxSum, M, Count, _CurrentSum) ->
    Count =< M;
can_split_impl([H|T], MaxSum, M, Count, CurrentSum) ->
    if
        CurrentSum + H =< MaxSum ->
            can_split_impl(T, MaxSum, M, Count, CurrentSum + H);
        true ->
            can_split_impl(T, MaxSum, M, Count + 1, H)
    end.