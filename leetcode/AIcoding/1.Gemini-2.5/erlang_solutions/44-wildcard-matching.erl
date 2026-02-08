-module(solution).
-export([isMatch/2]).

isMatch(S, P) ->
    CleanP = clean_pattern(P),

    S_bin = list_to_binary(S),
    P_bin = list_to_binary(CleanP),

    LenS = byte_size(S_bin),
    LenP = byte_size(P_bin),

    Memo = ets:new(wildcard_match_memo, [set, protected, {read_concurrency, true}]),
    Result = match(0, 0, S_bin, P_bin, LenS, LenP, Memo),
    ets:delete(Memo),
    Result.

clean_pattern(P) ->
    clean_pattern(P, []).

clean_pattern([], Acc) ->
    lists:reverse(Acc);
clean_pattern([$*,$* | T], Acc) ->
    clean_pattern([$* | T], Acc);
clean_pattern([H | T], Acc) ->
    clean_pattern(T, [H | Acc]).

match(IdxS, IdxP, S_bin, P_bin, LenS, LenP, Memo) ->
    case ets:lookup(Memo, {IdxS, IdxP}) of
        [{_, _, CachedResult}] ->
            CachedResult;
        [] ->
            Result = calculate_match(IdxS, IdxP, S_bin, P_bin, LenS, LenP, Memo),
            ets:insert(Memo, {{IdxS, IdxP}, Result}),
            Result
    end.

calculate_match(IdxS, IdxP, S_bin, P_bin, LenS, LenP, Memo) ->
    if IdxP == LenP ->
        IdxS == LenS;
    elseif IdxS == LenS ->
        is_all_asterisks_from_idx(IdxP, P_bin, LenP);
    else
        P_char = binary:at(P_bin, IdxP),
        S_char = binary:at(S_bin, IdxS),

        case P_char of
            $? ->
                match(IdxS + 1, IdxP + 1, S_bin, P_bin, LenS, LenP, Memo);
            $* ->
                match(IdxS, IdxP + 1, S_bin, P_bin, LenS, LenP, Memo) orelse
                match(IdxS + 1, IdxP, S_bin, P_bin, LenS, LenP, Memo);
            _ ->
                (S_char == P_char) andalso match(IdxS + 1, IdxP + 1, S_bin, P_bin, LenS, LenP, Memo)
        end
    end.

is_all_asterisks_from_idx(Idx, P_bin, LenP) ->
    if Idx == LenP ->
        true;
    else
        P_char = binary:at(P_bin, Idx),
        P_char == $* andalso is_all_asterisks_from_idx(Idx + 1, P_bin, LenP)
    end.