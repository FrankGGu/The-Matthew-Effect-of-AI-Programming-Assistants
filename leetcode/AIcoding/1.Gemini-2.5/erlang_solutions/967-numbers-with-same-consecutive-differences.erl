-module(solution).
-export([numsSameConsecDiff/2]).

numsSameConsecDiff(N, K) ->
    lists:flatten([dfs(Digit, N - 1, K) || Digit <- lists:seq(1, 9)]).

dfs(CurrentNum, RemainingDigits, K) ->
    if RemainingDigits == 0 ->
        [CurrentNum];
    true ->
        LastDigit = CurrentNum rem 10,
        NextDigits = get_next_digits(LastDigit, K),
        lists:flatten([dfs(CurrentNum * 10 + NextDigit, RemainingDigits - 1, K) || NextDigit <- NextDigits])
    end.

get_next_digits(LastDigit, K) ->
    Result1 = 
        case LastDigit + K of
            Next1 when Next1 >= 0 andalso Next1 =< 9 -> [Next1];
            _ -> []
        end,

    if K == 0 ->
        Result1;
    true ->
        Result2 = 
            case LastDigit - K of
                Next2 when Next2 >= 0 andalso Next2 =< 9 -> [Next2];
                _ -> []
            end,
        Result1 ++ Result2
    end.