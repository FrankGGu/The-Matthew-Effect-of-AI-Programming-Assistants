-module(solution).
-export([longest_ideal_subsequence/2]).

get_dp_val(Index, DP_List) ->
    lists:nth(Index + 1, DP_List).

set_dp_val(Index, Value, DP_List) ->
    lists:replace_nth(Index + 1, Value, DP_List).

get_max_in_range(Index, End, DP_List, CurrentMax) when Index =< End ->
    Val = get_dp_val(Index, DP_List),
    get_max_in_range(Index + 1, End, DP_List, max(CurrentMax, Val));
get_max_in_range(_Index, _End, _DP_List, CurrentMax) ->
    CurrentMax.

longest_ideal_subsequence(S, K) ->
    DP_List_Initial = lists:duplicate(26, 0),

    DP_List_Final = lists:foldl(
        fun(Char, AccDP_List) ->
            C_val = Char - $a,

            Min_Prev_Val = max(0, C_val - K),
            Max_Prev_Val = min(25, C_val + K),

            Current_Max_Len = get_max_in_range(Min_Prev_Val, Max_Prev_Val, AccDP_List, 0),

            New_Len = Current_Max_Len + 1,

            set_dp_val(C_val, New_Len, AccDP_List)
        end,
        DP_List_Initial,
        S
    ),

    lists:max(DP_List_Final).