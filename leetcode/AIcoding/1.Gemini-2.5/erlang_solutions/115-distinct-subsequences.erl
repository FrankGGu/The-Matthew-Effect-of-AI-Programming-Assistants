-module(solution).
-export([numDistinct/2]).

numDistinct(S, T) ->
    M = length(T),

    Prev_row = [1 | lists:duplicate(M, 0)],

    Final_row = lists:foldl(
        fun(S_char, Current_Prev_row) ->
            Curr_row_head = 1,

            {New_Curr_row_tail_reversed, _, _} = lists:foldl(
                fun(T_char, {Acc_curr_row_tail_rev, Prev_j_minus_1_val, [Prev_j_val | Prev_row_rest]}) ->
                    Current_val = 
                        if S_char == T_char ->
                            Prev_j_minus_1_val + Prev_j_val;
                        true ->
                            Prev_j_val
                        end,

                    {[Current_val | Acc_curr_row_tail_rev], Prev_j_val, Prev_row_rest}
                end,
                {[], hd(Current_Prev_row), tl(Current_Prev_row)},
                T
            ),
            [Curr_row_head | lists:reverse(New_Curr_row_tail_reversed)]
        end,
        Prev_row,
        S
    ),

    lists:last(Final_row).