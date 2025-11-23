-module(solution).
-export([is_match/2]).

-include_lib("kernel/include/array.hrl").

is_match(S1_list, S2_list) ->
    S1 = array:from_list(S1_list),
    S2 = array:from_list(S2_list),
    Memo = dict:new(),
    % Diff range: -998 to 998. Offset by 998 to make it non-negative.
    % So, Diff_offset = Diff + 998. Max offset 1996, Min offset 0.
    {Result, _FinalMemo} = dp(0, 0, 0 + 998, S1, S2, Memo),
    Result.

dp(Idx1, Idx2, Diff_offset, S1, S2, Memo) ->
    S1_len = array:size(S1),
    S2_len = array:size(S2),

    if
        Idx1 == S1_len andalso Idx2 == S2_len ->
            Diff = Diff_offset - 998,
            if Diff == 0 -> {true, Memo};
            true -> {false, Memo}
            end;
        true ->
            case dict:find({Idx1, Idx2, Diff_offset}, Memo) of
                {ok, Result} ->
                    {Result, Memo};
                _ ->
                    {Result, NewMemo} = solve(Idx1, Idx2, Diff_offset, S1, S2, Memo),
                    {Result, dict:store({Idx1, Idx2, Diff_offset}, Result, NewMemo)}
            end
    end.

solve(Idx1, Idx2, Diff_offset, S1, S2, Memo) ->
    Diff = Diff_offset - 998,
    S1_len = array:size(S1),
    S2_len = array:size(S2),

    Char1 = get_char(S1, Idx1, S1_len),
    Char2 = get_char(S2, Idx2, S2_len),

    if Char1 == undefined ->
        if Diff < 0 -> {false, Memo};
        true ->
                solve_s2_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo)
        end;
    Char2 == undefined ->
        if Diff > 0 -> {false, Memo};
        true ->
                solve_s1_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo)
        end;
    true ->
        if Diff == 0 ->
            if is_letter(Char1) andalso is_letter(Char2) ->
                if Char1 == Char2 ->
                    dp(Idx1 + 1, Idx2 + 1, Diff_offset, S1, S2, Memo);
                true ->
                    {false, Memo}
                end;
            is_letter(Char1) andalso is_digit(Char2) ->
                {Num2, Len2} = parse_num(S2, Idx2, S2_len),
                dp(Idx1 + 1, Idx2 + Len2, Diff_offset - Num2 + 1, S1, S2, Memo);
            is_digit(Char1) andalso is_letter(Char2) ->
                {Num1, Len1} = parse_num(S1, Idx1, S1_len),
                dp(Idx1 + Len1, Idx2 + 1, Diff_offset + Num1 - 1, S1, S2, Memo);
            is_digit(Char1) andalso is_digit(Char2) ->
                {Num1, Len1} = parse_num(S1, Idx1, S1_len),
                {Num2, Len2} = parse_num(S2, Idx2, S2_len),
                dp(Idx1 + Len1, Idx2 + Len2, Diff_offset + Num1 - Num2, S1, S2, Memo)
            end;
        Diff > 0 ->
            solve_s2_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo);
        Diff < 0 ->
            solve_s1_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo)
        end
    end.

solve_s2_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo) ->
    S2_len = array:size(S2),
    Char2 = get_char(S2, Idx2, S2_len),
    case Char2 of
        undefined -> {false, Memo};
        C2 when is_letter(C2) ->
            dp(Idx1, Idx2 + 1, Diff_offset - 1, S1, S2, Memo);
        C2 when is_digit(C2) ->
            {Num2, Len2} = parse_num(S2, Idx2, S2_len),
            dp(Idx1, Idx2 + Len2, Diff_offset - Num2, S1, S2, Memo)
    end.

solve_s1_catch_up(Idx1, Idx2, Diff_offset, S1, S2, Memo) ->
    S1_len = array:size(S1),
    Char1 = get_char(S1, Idx1, S1_len),
    case Char1 of
        undefined -> {false, Memo};
        C1 when is_letter(C1) ->
            dp(Idx1 + 1, Idx2, Diff_offset + 1, S1, S2, Memo);
        C1 when is_digit(C1) ->
            {Num1, Len1} = parse_num(S1, Idx1, S1_len),
            dp(Idx1 + Len1, Idx2, Diff_offset + Num1, S1, S2, Memo)
    end.

is_digit(Char) when Char >= $0 andalso Char <= $9 -> true;
is_digit(_) -> false.

is_letter(Char) when Char >= $a andalso Char <= $z -> true;
is_letter(_) -> false.

get_char(Array, Idx, ArrayLen) ->
    case Idx < ArrayLen of
        true -> array:get(Idx, Array);
        false -> undefined
    end.

parse_num(Array, StartIdx, ArrayLen) ->
    parse_num_acc(Array, StartIdx, ArrayLen, 0, 0).

parse_num_acc(Array, CurrentIdx, ArrayLen, AccNum, Len) ->
    Char = get_char(Array, CurrentIdx, ArrayLen),
    case Char of
        C when is_digit(C) ->
            Digit = C - $0,
            parse_num_acc(Array, CurrentIdx + 1, ArrayLen, AccNum * 10 + Digit, Len + 1);
        _ ->
            {AccNum, Len}
    end.