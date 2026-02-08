-module(solution).
-export([is_interleave/3]).

is_interleave(S1_list, S2_list, S3_list) ->
    Len1 = length(S1_list),
    Len2 = length(S2_list),
    Len3 = length(S3_list),

    if
        Len1 + Len2 =/= Len3 ->
            false;
        true ->
            S1 = list_to_tuple(S1_list),
            S2 = list_to_tuple(S2_list),
            S3 = list_to_tuple(S3_list),

            DP = array:new([{size, Len1 + 1}, {fixed, true}, {default, array:new([{size, Len2 + 1}, {fixed, true}, {default, false}])}]),

            Row0 = array:get(0, DP),
            Row0_updated = array:set(0, true, Row0),
            DP_with_base = array:set(0, Row0_updated, DP),

            DP_after_row0 = fill_first_row(1, Len2, S2, S3, DP_with_base),

            DP_after_col0 = fill_first_col(1, Len1, S1, S3, DP_after_row0),

            FinalDP = fill_dp(1, Len1, 1, Len2, S1, S2, S3, DP_after_col0),

            array:get(Len2, array:get(Len1, FinalDP))
    end.

fill_first_row(J, MaxJ, S2, S3, CurrentDP) when J =< MaxJ ->
    Row0 = array:get(0, CurrentDP),
    PrevResult = array:get(J-1, Row0),

    S2_char = element(J, S2),
    S3_char = element(J, S3),

    Result = PrevResult andthen (S2_char =:= S3_char),

    NewRow0 = array:set(J, Result, Row0),
    NewDP = array:set(0, NewRow0, CurrentDP),
    fill_first_row(J+1, MaxJ, S2, S3, NewDP);
fill_first_row(_J, _MaxJ, _S2, _S3, CurrentDP) ->
    CurrentDP.

fill_first_col(I, MaxI, S1, S3, CurrentDP) when I =< MaxI ->
    PrevRow = array:get(I-1, CurrentDP),
    PrevResult = array:get(0, PrevRow),

    S1_char = element(I, S1),
    S3_char = element(I, S3),

    Result = PrevResult andthen (S1_char =:= S3_char),

    CurrentRow = array:get(I, CurrentDP),
    NewRow = array:set(0, Result, CurrentRow),
    NewDP = array:set(I, NewRow, CurrentDP),
    fill_first_col(I+1, MaxI, S1, S3, NewDP);
fill_first_col(_I, _MaxI, _S1, _S3, CurrentDP) ->
    CurrentDP.

fill_dp(I, MaxI, J_start, MaxJ, S1, S2, S3, CurrentDP) when I =< MaxI ->
    CurrentDP_row_filled = fill_dp_row(I, J_start, MaxJ, S1, S2, S3, CurrentDP),
    fill_dp(I+1, MaxI, J_start, MaxJ, S1, S2, S3, CurrentDP_row_filled);
fill_dp(_I, _MaxI, _J_start, _MaxJ, _S1, _S2, _S3, CurrentDP) ->
    CurrentDP.

fill_dp_row(I, J, MaxJ, S1, S2, S3, CurrentDP) when J =< MaxJ ->
    PrevRow_I_minus_1 = array:get(I-1, CurrentDP),
    Result1 = (element(I, S1) =:= element(I+J, S3)) andthen array:get(J, PrevRow_I_minus_1),

    CurrentRow_I = array:get(I, CurrentDP),
    Result2 = (element(J, S2) =:= element(I+J, S3)) andthen array:get(J-1, CurrentRow_I),

    Result = Result1 orelse Result2,

    NewRow_I = array:set(J, Result, CurrentRow_I),
    NewDP = array:set(I, NewRow_I, CurrentDP),
    fill_dp_row(I, J+1, MaxJ, S1, S2, S3, NewDP);
fill_dp_row(_I, _J, _MaxJ, _S1, _S2, _S3, CurrentDP) ->
    CurrentDP.