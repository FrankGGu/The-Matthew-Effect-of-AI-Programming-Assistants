-module(solution).
-export([minimum_length/1]).

minimum_length(S) ->
    LenS = length(S),
    if LenS == 0 -> 0;
       true -> min_len_recursive(S, lists:reverse(S), 0, LenS - 1)
    end.

min_len_recursive(L, R, L_idx, R_idx) ->
    if L_idx >= R_idx ->
        max(0, R_idx - L_idx + 1);
    true ->
        [LChar|_] = L,
        [RChar|_] = R,

        if LChar /= RChar ->
            R_idx - L_idx + 1;
        true ->
            CharToRemove = LChar,

            {NewL, NewL_idx} = advance_left(L, L_idx, R_idx, CharToRemove),

            {NewR, NewR_idx} = advance_right(R, NewL_idx, R_idx, CharToRemove),

            min_len_recursive(NewL, NewR, NewL_idx, NewR_idx)
        end
    end.

advance_left(L, L_idx, R_idx, Char) ->
    if L_idx <= R_idx andalso L /= [] andalso hd(L) == Char ->
        advance_left(tl(L), L_idx + 1, R_idx, Char);
    true ->
        {L, L_idx}
    end.

advance_right(R, L_idx, R_idx, Char) ->
    if L_idx <= R_idx andalso R /= [] andalso hd(R) == Char ->
        advance_right(tl(R), L_idx, R_idx - 1, Char);
    true ->
        {R, R_idx}
    end.