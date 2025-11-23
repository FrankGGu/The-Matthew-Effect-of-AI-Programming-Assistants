-module(solution).
-export([max_deletions/1]).

max_deletions(S_str) ->
    S_bin = list_to_binary(S_str),
    N = byte_size(S_bin),

    if N == 0 -> 0;
       true ->
            LCP_rows = array:new(N + 1),
            LCP_rows_init = fill_lcp_rows_init(N, LCP_rows),

            Final_LCP_rows = fill_lcp_table(N - 1, N - 1, S_bin, LCP_rows_init),

            dp = array:new(N + 1, {default, 0}),

            Final_dp = fill_dp_table(N - 1, N, S_bin, Final_LCP_rows, dp),

            array:get(0, Final_dp)
    end.

fill_lcp_rows_init(N, LCP_rows) ->
    lists:foldl(fun(I, AccLCPRows) ->
        array:set(I, array:new(N + 1, {default, 0}), AccLCPRows)
    end, LCP_rows, lists:seq(0, N)).

fill_lcp_table(I, J, S_bin, LCP_rows) when I < 0 ->
    LCP_rows;
fill_lcp_table(I, J, S_bin, LCP_rows) when J < 0 ->
    fill_lcp_table(I - 1, byte_size(S_bin) - 1, S_bin, LCP_rows);
fill_lcp_table(I, J, S_bin, LCP_rows) ->
    Val = case {I, J} of
        {_, _} when I == byte_size(S_bin) or J == byte_size(S_bin) -> 0;
        {_, _} when binary:at(S_bin, I) == binary:at(S_bin, J) ->
            Row_I_plus_1 = array:get(I + 1, LCP_rows),
            LCP_val_next = array:get(J + 1, Row_I_plus_1),
            1 + LCP_val_next;
        _ -> 0
    end,
    Current_Row_I = array:get(I, LCP_rows),
    Updated_Row_I = array:set(J, Val, Current_Row_I),
    Updated_LCP_rows = array:set(I, Updated_Row_I, LCP_rows),
    fill_lcp_table(I, J - 1, S_bin, Updated_LCP_rows).

fill_dp_table(I, N, S_bin, LCP_rows, dp) when I < 0 ->
    dp;
fill_dp_table(I, N, S_bin, LCP_rows, dp) ->
    Current_Max = 1,
    Max_L = (N - I) div 2,
    New_Max = find_max_l_for_dp(1, Max_L, I, N, LCP_rows, dp, Current_Max),
    Updated_dp = array:set(I, New_Max, dp),
    fill_dp_table(I - 1, N, S_bin, LCP_rows, Updated_dp).

find_max_l_for_dp(L, Max_L, I, N, LCP_rows, dp, Current_Max) when L > Max_L ->
    Current_Max;
find_max_l_for_dp(L, Max_L, I, N, LCP_rows, dp, Current_Max) ->
    Row_I = array:get(I, LCP_rows),
    LCP_val = array:get(I + L, Row_I),
    If_LCP_Match = if
        LCP_val >= L ->
            DP_val_next = array:get(I + L, dp),
            max(Current_Max, 1 + DP_val_next);
        true -> Current_Max
    end,
    find_max_l_for_dp(L + 1, Max_L, I, N, LCP_rows, dp, If_LCP_Match).