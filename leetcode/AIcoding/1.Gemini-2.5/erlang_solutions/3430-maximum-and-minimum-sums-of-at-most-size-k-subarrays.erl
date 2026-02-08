-module(solution).
-export([solve/2]).

-include_lib("stdlib/include/array.hrl").

solve(Nums, K) ->
    N = length(Nums),
    PrefixSums = calculate_prefix_sums(Nums, N),

    MaxSum = calculate_max_sum(PrefixSums, K, N),
    MinSum = calculate_min_sum(PrefixSums, K, N),

    {MaxSum, MinSum}.

calculate_prefix_sums(Nums, N) ->
    Array = array:new([{size, N + 1}, {fixed, true}]),
    Array0 = array:set(0, 0, Array),

    lists:foldl(fun(Idx, AccArray) ->
        PrevSum = array:get(Idx - 1, AccArray),
        CurrentNum = lists:nth(Idx, Nums),
        array:set(Idx, PrevSum + CurrentNum, AccArray)
    end, Array0, lists:seq(1, N)).

deque_new() -> {[], []}.
deque_is_empty({[], []}) -> true;
deque_is_empty(_) -> false.

deque_push_back(Val, {Front, BackReversed}) -> {Front, [Val | BackReversed]}.

deque_pop_front({[], []}) -> {empty, {[], []}};
deque_pop_front({[H|T], BackReversed}) -> {H, {T, BackReversed}};
deque_pop_front({[], BackReversed}) ->
    NewFront = lists:reverse(BackReversed),
    deque_pop_front({NewFront, []}).

deque_peek_front({[], []}) -> empty;
deque_peek_front({[H|_], _}) -> H;
deque_peek_front({[], BackReversed}) ->
    NewFront = lists:reverse(BackReversed),
    deque_peek_front({NewFront, []}).

deque_peek_back({[], []}) -> empty;
deque_peek_back({_, [H|_]}) -> H;
deque_peek_back({Front, []}) ->
    NewBackReversed = lists:reverse(Front),
    deque_peek_back({[], NewBackReversed}).

deque_pop_back({[], []}) -> {empty, {[], []}};
deque_pop_back({Front, [H|T]}) -> {H, {Front, T}};
deque_pop_back({Front, []}) ->
    NewBackReversed = lists:reverse(Front),
    deque_pop_back({[], NewBackReversed}).

calculate_max_sum(PrefixSums, K, N) ->
    MaxSum = -infinity,
    DQ = deque_new(),

    DQ1 = deque_push_back(0, DQ),

    calculate_max_sum_loop(1, N, PrefixSums, K, MaxSum, DQ1).

calculate_max_sum_loop(J, N, PrefixSums, K, CurrentMaxSum, DQ) when J =< N ->
    DQ1 = deque_pop_front_while_out_of_window(J, K, DQ),

    Sum = case deque_peek_front(DQ1) of
        empty -> CurrentMaxSum;
        PrevIdx ->
            P_J = array:get(J, PrefixSums),
            P_PrevIdx = array:get(PrevIdx, PrefixSums),
            max(CurrentMaxSum, P_J - P_PrevIdx)
    end,

    P_J = array:get(J, PrefixSums),
    DQ2 = deque_pop_back_while_greater_equal(P_J, PrefixSums, DQ1),

    DQ3 = deque_push_back(J, DQ2),

    calculate_max_sum_loop(J + 1, N, PrefixSums, K, Sum, DQ3);
calculate_max_sum_loop(_J, _N, _PrefixSums, _K, CurrentMaxSum, _DQ) ->
    CurrentMaxSum.

deque_pop_front_while_out_of_window(J, K, DQ) ->
    case deque_peek_front(DQ) of
        empty -> DQ;
        PrevIdx when J - PrevIdx > K ->
            {_, DQ1} = deque_pop_front(DQ),
            deque_pop_front_while_out_of_window(J, K, DQ1);
        _ -> DQ
    end.

deque_pop_back_while_greater_equal(PJ, PrefixSums, DQ) ->
    case deque_peek_back(DQ) of
        empty -> DQ;
        PrevIdx ->
            P_PrevIdx = array:get(PrevIdx, PrefixSums),
            if P_PrevIdx >= PJ ->
                {_, DQ1} = deque_pop_back(DQ),
                deque_pop_back_while_greater_equal(PJ, PrefixSums, DQ1);
            true -> DQ
            end
    end.

calculate_min_sum(PrefixSums, K, N) ->
    MinSum = infinity,
    DQ = deque_new(),

    DQ1 = deque_push_back(0, DQ),

    calculate_min_sum_loop(1, N, PrefixSums, K, MinSum, DQ1).

calculate_min_sum_loop(J, N, PrefixSums, K, CurrentMinSum, DQ) when J =< N ->
    DQ1 = deque_pop_front_while_out_of_window(J, K, DQ),

    Sum = case deque_peek_front(DQ1) of
        empty -> CurrentMinSum;
        PrevIdx ->
            P_J = array:get(J, PrefixSums),
            P_PrevIdx = array:get(PrevIdx, PrefixSums),
            min(CurrentMinSum, P_J - P_PrevIdx)
    end,

    P_J = array:get(J, PrefixSums),
    DQ2 = deque_pop_back_while_less_equal(P_J, PrefixSums, DQ1),

    DQ3 = deque_push_back(J, DQ2),

    calculate_min_sum_loop(J + 1, N, PrefixSums, K, Sum, DQ3);
calculate_min_sum_loop(_J, _N, _PrefixSums, _K, CurrentMinSum, _DQ) ->
    CurrentMinSum.

deque_pop_back_while_less_equal(PJ, PrefixSums, DQ) ->
    case deque_peek_back(DQ) of
        empty -> DQ;
        PrevIdx ->
            P_PrevIdx = array:get(PrevIdx, PrefixSums),
            if P_PrevIdx =< PJ ->
                {_, DQ1} = deque_pop_back(DQ),
                deque_pop_back_while_less_equal(PJ, PrefixSums, DQ1);
            true -> DQ
            end
    end.