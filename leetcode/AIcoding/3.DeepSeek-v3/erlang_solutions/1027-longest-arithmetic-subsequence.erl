-module(solution).
-export([longest_arith_seq_length/1]).

longest_arith_seq_length(Nums) ->
    N = length(Nums),
    if N =< 2 -> N;
    true ->
        DP = maps:new(),
        Max = 1,
        longest_arith_seq(Nums, 1, DP, Max)
    end.

longest_arith_seq([], _I, _DP, Max) -> Max;
longest_arith_seq([H | T], I, DP, Max) ->
    NewDP = maps:new(),
    {NewDP1, NewMax} = check_prev_elements(T, H, I, 0, DP, NewDP, Max),
    longest_arith_seq(T, I + 1, NewDP1, NewMax).

check_prev_elements([], _Current, _I, _J, DP, NewDP, Max) -> {DP, Max};
check_prev_elements([H | T], Current, I, J, DP, NewDP, Max) ->
    Diff = Current - H,
    Key = {J, Diff},
    case maps:get(Key, DP, 1) of
        Val ->
            NewVal = Val + 1,
            NewDP1 = maps:put({I, Diff}, NewVal, NewDP),
            NewMax = max(Max, NewVal),
            check_prev_elements(T, Current, I, J + 1, DP, NewDP1, NewMax)
    end.