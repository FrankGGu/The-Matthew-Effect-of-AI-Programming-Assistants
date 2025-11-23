-module(solution).
-export([constrainedSubsequenceSum/2]).

constrainedSubsequenceSum(Nums, K) ->
    N = length(Nums),
    case Nums of
        [] -> 0;
        [H|_] ->
            DP = array:from_list(Nums),
            InitialDeque = deque_in(0, deque_new()),
            InitialMaxSum = H,
            process_nums(1, N, K, DP, InitialDeque, InitialMaxSum)
    end.

process_nums(Idx, N, _K, DP, _DQ, MaxSum) when Idx >= N ->
    MaxSum;
process_nums(Idx, N, K, DP, DQ, MaxSumAcc) ->
    FilteredDQ = deque_filter_old(DQ, Idx - K),

    PrevMaxDPVal = case deque_peek_front(FilteredDQ) of
                       {ok, PrevIdx} ->
                           array:get(PrevIdx, DP);
                       _ ->
                           0
                   end,

    CurrentNum = array:get(Idx, DP),
    CurrentDP = CurrentNum + max(0, PrevMaxDPVal),

    UpdatedDP = array:set(Idx, CurrentDP, DP),

    NewMaxSumAcc = max(MaxSumAcc, CurrentDP),

    TrimmedDQ = deque_trim_back(FilteredDQ, CurrentDP, UpdatedDP),

    NewDQ = deque_in(Idx, TrimmedDQ),

    process_nums(Idx + 1, N, K, UpdatedDP, NewDQ, NewMaxSumAcc).

deque_new() -> {[], []}.

deque_in(X, {F, B}) -> {F, [X|B]}.

deque_rebalance_for_front({[], B}) -> {lists:reverse(B), []};
deque_rebalance_for_front(DQ) -> DQ.

deque_rebalance_for_back({F, []}) -> {[], lists:reverse(F)};
deque_rebalance_for_back(DQ) -> DQ.

deque_peek_front(DQ = {[H|_], _}) ->
    {ok, H};
deque_peek_front(DQ = {[], _}) ->
    case deque_rebalance_for_front(DQ) of
        {[H|_], _} -> {ok, H};
        {[], []} -> empty
    end.

deque_out(DQ = {[H|T], B}) ->
    {ok, H, {T, B}};
deque_out(DQ = {[], _}) ->
    case deque_rebalance_for_front(DQ) of
        {[H|T], []} -> {ok, H, {T, []}};
        {[], []} -> empty
    end.

deque_peek_back({_, [H|_]}) ->
    {ok, H};
deque_peek_back(DQ = {F, []}) ->
    case deque_rebalance_for_back(DQ) of
        {_, [H|_]} -> {ok, H};
        {[], []} -> empty
    end.

deque_out_back({F, [_|T]}) ->
    {ok, {F, T}};
deque_out_back(DQ = {F, []}) ->
    case deque_rebalance_for_back(DQ) of
        {[], [_|T]} -> {ok, {[], T}};
        {[], []} -> empty
    end.

deque_filter_old(DQ, MinIdx) ->
    case deque_peek_front(DQ) of
        {ok, Idx} when Idx < MinIdx ->
            {ok, _Elem, DQ1} = deque_out(DQ),
            deque_filter_old(DQ1, MinIdx);
        _ ->
            DQ
    end.

deque_trim_back(DQ, CurrentDP, DP_Array) ->
    case deque_peek_back(DQ) of
        {ok, Idx} ->
            Val = array:get(Idx, DP_Array),
            if Val =< CurrentDP ->
                {ok, DQ1} = deque_out_back(DQ),
                deque_trim_back(DQ1, CurrentDP, DP_Array);
            true ->
                DQ
            end;
        _ ->
            DQ
    end.