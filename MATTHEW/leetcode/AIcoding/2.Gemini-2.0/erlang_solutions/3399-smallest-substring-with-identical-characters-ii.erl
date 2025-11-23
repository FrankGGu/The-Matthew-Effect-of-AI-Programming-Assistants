-module(smallest_substring_ii).
-export([smallest_substring_ii/2]).

smallest_substring_ii(S, K) ->
    Len = length(S),
    Result = case K > Len of
        true -> -1;
        false -> smallest_substring_ii_helper(S, K, Len)
    end,
    Result.

smallest_substring_ii_helper(S, K, Len) ->
    smallest_substring_ii_helper(S, K, Len, infinity).

smallest_substring_ii_helper(S, K, Len, MinLen) ->
    smallest_substring_ii_helper(S, K, Len, 0, Len - 1, MinLen).

smallest_substring_ii_helper(_S, _K, _Len, L, R, MinLen) when L > R ->
    case MinLen == infinity of
        true -> -1;
        false -> MinLen
    end;

smallest_substring_ii_helper(S, K, Len, L, R, MinLen) ->
    smallest_substring_ii_helper(S, K, Len, L, R, MinLen, L, L - 1, []).

smallest_substring_ii_helper(S, K, Len, L, R, MinLen, CurrL, CurrR, CharCounts) when CurrR >= R ->
    case CurrL > R of
        true ->
            smallest_substring_ii_helper(S, K, Len, L + 1, R, MinLen);
        false ->
            case check_substring(CharCounts, K) of
                true ->
                    NewMinLen = min(MinLen, CurrR - CurrL + 1),
                    smallest_substring_ii_helper(S, K, Len, L + 1, R, NewMinLen);
                false ->
                    smallest_substring_ii_helper(S, K, Len, L + 1, R, MinLen)
            end
    end;

smallest_substring_ii_helper(S, K, Len, L, R, MinLen, CurrL, CurrR, CharCounts) ->
    NextR = CurrR + 1,
    Char = lists:nth(NextR + 1, S),
    NewCharCounts = update_char_counts(Char, CharCounts),
    case check_substring(NewCharCounts, K) of
        true ->
            NewMinLen = min(MinLen, NextR - CurrL + 1),
            smallest_substring_ii_helper(S, K, Len, L, R, NewMinLen, CurrL, NextR, NewCharCounts);
        false ->
            smallest_substring_ii_helper(S, K, Len, L, R, MinLen, CurrL, NextR, NewCharCounts)
    end.

update_char_counts(Char, CharCounts) ->
    case lists:keyfind(Char, 1, CharCounts) of
        false ->
            [{Char, 1} | CharCounts];
        {Char, Count} ->
            lists:keyreplace(Char, 1, CharCounts, {Char, Count + 1})
    end.

check_substring(CharCounts, K) ->
    check_substring(CharCounts, K, false).

check_substring([], _K, Result) ->
    Result;
check_substring([{_Char, Count} | Rest], K, Result) ->
    case Count >= K of
        true ->
            check_substring(Rest, K, true);
        false ->
            check_substring(Rest, K, Result)
    end.