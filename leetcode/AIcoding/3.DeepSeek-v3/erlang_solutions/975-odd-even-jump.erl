-module(solution).
-export([oddEvenJumps/1]).

oddEvenJumps(Arr) ->
    N = length(Arr),
    {Odd, Even} = make_jumps(Arr, N),
    count_reachable(Odd, Even, N).

make_jumps(Arr, N) ->
    Sorted = lists:zip(lists:seq(1, N), Arr),
    SortedByVal = lists:sort(fun({I, A}, {J, B}) -> 
        if A =:= B -> I =< J; true -> A =< B end 
    end, Sorted),
    Odd = make_next(SortedByVal, N),
    SortedByValDesc = lists:sort(fun({I, A}, {J, B}) -> 
        if A =:= B -> I =< J; true -> A >= B end 
    end, Sorted),
    Even = make_next(SortedByValDesc, N),
    {Odd, Even}.

make_next(Sorted, N) ->
    Next = array:new(N, {default, -1}),
    Stack = [],
    {Next1, _} = lists:foldl(fun({I, _}, {NextAcc, StackAcc}) ->
        case StackAcc of
            [] -> {NextAcc, [I]};
            [Top | Rest] ->
                {array:set(I - 1, Top, NextAcc), [I | StackAcc]}
        end
    end, {Next, Stack}, Sorted),
    Next1.

count_reachable(Odd, Even, N) ->
    DP = array:new(N, {default, {false, false}}),
    DP1 = array:set(N - 1, {true, true}, DP),
    {DP2, Count} = lists:foldl(fun(I, {DPAcc, Cnt}) ->
        OddNext = array:get(I - 1, Odd),
        EvenNext = array:get(I - 1, Even),
        CanOdd = if OddNext =:= -1 -> false; true -> 
            {_, EvenReach} = array:get(OddNext - 1, DPAcc), EvenReach end,
        CanEven = if EvenNext =:= -1 -> false; true -> 
            {OddReach, _} = array:get(EvenNext - 1, DPAcc), OddReach end,
        DPNew = array:set(I - 1, {CanOdd, CanEven}, DPAcc),
        CntNew = if CanOdd -> Cnt + 1; true -> Cnt end,
        {DPNew, CntNew}
    end, {DP1, 1}, lists:seq(N - 1, 1, -1)),
    Count.