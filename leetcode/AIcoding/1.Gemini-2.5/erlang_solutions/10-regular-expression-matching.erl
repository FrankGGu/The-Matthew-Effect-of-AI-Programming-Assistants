-module(solution).
-export([isMatch/2]).

isMatch(S, P) ->
    SLen = length(S),
    PLen = length(P),
    {Result, _FinalMemo} = is_match_memo(0, 0, S, P, SLen, PLen, #{}),
    Result.

is_match_memo(S_idx, P_idx, S_chars, P_chars, SLen, PLen, Memo) ->
    case maps:find({S_idx, P_idx}, Memo) of
        {ok, Result} ->
            {Result, Memo};
        _ ->
            {Result, UpdatedMemo} = calculate_match(S_idx, P_idx, S_chars, P_chars, SLen, PLen, Memo),
            {Result, maps:put({S_idx, P_idx}, Result, UpdatedMemo)}
    end.

calculate_match(S_idx, P_idx, S_chars, P_chars, SLen, PLen, CurrentMemo) ->
    if P_idx == PLen ->
        {S_idx == SLen, CurrentMemo};
    true ->
        P_char = lists:nth(P_idx + 1, P_chars),

        P_has_star = (P_idx + 1 < PLen) andalso (lists:nth(P_idx + 2, P_chars) == $*);

        if P_has_star ->
            % Option 1: X* matches zero occurrences of X
            {Res1, Memo1} = is_match_memo(S_idx, P_idx + 2, S_chars, P_chars, SLen, PLen, CurrentMemo),
            if Res1 ->
                {true, Memo1};
            true ->
                % Option 2: X* matches one or more occurrences of X
                S_char_matches = (S_idx < SLen) andalso
                                 (P_char == $. orelse lists:nth(S_idx + 1, S_chars) == P_char);
                if S_char_matches ->
                    {Res2, Memo2} = is_match_memo(S_idx + 1, P_idx, S_chars, P_chars, SLen, PLen, Memo1),
                    {Res2, Memo2};
                true ->
                    {false, Memo1}
                end
            end;
        true ->
            % Case: Pattern is X... (where X is not followed by *)
            S_char_matches = (S_idx < SLen) andalso
                             (P_char == $. orelse lists:nth(S_idx + 1, S_chars) == P_char);
            if S_char_matches ->
                {Res, Memo_final} = is_match_memo(S_idx + 1, P_idx + 1, S_chars, P_chars, SLen, PLen, CurrentMemo),
                {Res, Memo_final};
            true ->
                {false, CurrentMemo}
            end
        end
    end.