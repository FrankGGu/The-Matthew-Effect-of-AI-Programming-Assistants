-module(solution).
-export([isScramble/2]).

isScramble(S1, S2) ->
    {Result, _Memo} = isScramble_memo(S1, S2, #{}),
    Result.

isScramble_memo(S1, S2, Memo) ->
    Key = {S1, S2},
    case maps:find(Key, Memo) of
        {ok, Result} ->
            {Result, Memo};
        error ->
            Len = length(S1),
            if
                Len =/= length(S2) ->
                    {false, maps:put(Key, false, Memo)};
                S1 == S2 ->
                    {true, maps:put(Key, true, Memo)};
                Len == 0 ->
                    {true, maps:put(Key, true, Memo)};
                lists:sort(S1) =/= lists:sort(S2) ->
                    {false, maps:put(Key, false, Memo)};
                true ->
                    {Result, FinalMemo} = try_all_splits(S1, S2, Len, 1, Memo),
                    {Result, maps:put(Key, Result, FinalMemo)}
            end
    end.

try_all_splits(_S1, _S2, Len, I, Memo) when I >= Len ->
    {false, Memo};
try_all_splits(S1, S2, Len, I, Memo) ->
    S1_left = lists:sublist(S1, 1, I),
    S1_right = lists:sublist(S1, I + 1, Len - I),

    % Case 1: No swap
    S2_left_no_swap = lists:sublist(S2, 1, I),
    S2_right_no_swap = lists:sublist(S2, I + 1, Len - I),

    {Res1_left_val, MemoAfter1_1} = isScramble_memo(S1_left, S2_left_no_swap, Memo),
    if Res1_left_val ->
        {Res1_right_val, MemoAfter1_2} = isScramble_memo(S1_right, S2_right_no_swap, MemoAfter1_1),
        if Res1_right_val ->
            {true, MemoAfter1_2};
        true ->
            % No swap failed, try with swap using MemoAfter1_2
            % Case 2: With swap
            S2_left_swap = lists:sublist(S2, 1, Len - I),
            S2_right_swap = lists:sublist(S2, Len - I + 1, I),

            {Res2_left_val, MemoAfter2_1} = isScramble_memo(S1_left, S2_right_swap, MemoAfter1_2),
            if Res2_left_val ->
                {Res2_right_val, MemoAfter2_2} = isScramble_memo(S1_right, S2_left_swap, MemoAfter2_1),
                if Res2_right_val ->
                    {true, MemoAfter2_2};
                true ->
                    try_all_splits(S1, S2, Len, I + 1, MemoAfter2_2)
                end;
            true ->
                try_all_splits(S1, S2, Len, I + 1, MemoAfter2_1)
            end
        end;
    true ->
        % Case 1_left failed, try Case 2 directly using MemoAfter1_1
        S2_left_swap = lists:sublist(S2, 1, Len - I),
        S2_right_swap = lists:sublist(S2, Len - I + 1, I),

        {Res2_left_val, MemoAfter2_1} = isScramble_memo(S1_left, S2_right_swap, MemoAfter1_1),
        if Res2_left_val ->
            {Res2_right_val, MemoAfter2_2} = isScramble_memo(S1_right, S2_left_swap, MemoAfter2_1),
            if Res2_right_val ->
                {true, MemoAfter2_2};
            true ->
                try_all_splits(S1, S2, Len, I + 1, MemoAfter2_2)
            end;
        true ->
            try_all_splits(S1, S2, Len, I + 1, MemoAfter2_1)
        end
    end.