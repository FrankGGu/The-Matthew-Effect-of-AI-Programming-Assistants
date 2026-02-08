-module(solution).
-export([countSteppingNumbers/2]).

countSteppingNumbers(LowStr, HighStr) ->
    CountHigh = count_stepping_up_to(HighStr),
    CountLowMinus1 = if LowStr == "0" -> 0;
                       true ->
                           LowInt = list_to_integer(LowStr),
                           count_stepping_up_to(integer_to_list(LowInt - 1))
                    end,
    CountHigh - CountLowMinus1.

count_stepping_up_to(S_str) ->
    S_digits = [C - $0 || C <- S_str],
    N = length(S_digits),
    Memo = ets:new(stepping_memo, [set, public, {read_concurrency, true}]),

    Ans = dp(0, -1, false, false, S_digits, N, Memo),
    ets:delete(Memo),
    Ans.

dp(Idx, PrevDigit, IsLess, IsStarted, S_digits, N, Memo) ->
    Key = {Idx, PrevDigit, IsLess, IsStarted},
    case ets:lookup(Memo, Key) of
        [{Key, Value}] -> Value;
        [] ->
            if Idx == N ->
                ets:insert(Memo, {Key, 1}),
                1;
            true ->
                UpperLimit = if IsLess -> 9;
                             true -> lists:nth(Idx + 1, S_digits)
                             end,
                CurrentAns = calculate_transitions(0, UpperLimit, Idx, PrevDigit, IsLess, IsStarted, S_digits, N, Memo),
                ets:insert(Memo, {Key, CurrentAns}),
                CurrentAns
            end
    end.

calculate_transitions(Digit, UpperLimit, Idx, PrevDigit, IsLess, IsStarted, S_digits, N, Memo) when Digit > UpperLimit ->
    0;
calculate_transitions(Digit, UpperLimit, Idx, PrevDigit, IsLess, IsStarted, S_digits, N, Memo) ->
    Sum = if IsStarted == false ->
              if Digit == 0 ->
                  dp(Idx + 1, PrevDigit, IsLess or (Digit < UpperLimit), false, S_digits, N, Memo);
              true ->
                  dp(Idx + 1, Digit, IsLess or (Digit < UpperLimit), true, S_digits, N, Memo)
              end;
          true ->
              if abs(Digit - PrevDigit) == 1 ->
                  dp(Idx + 1, Digit, IsLess or (Digit < UpperLimit), true, S_digits, N, Memo);
              true ->
                  0
              end
          end,
    Sum + calculate_transitions(Digit + 1, UpperLimit, Idx, PrevDigit, IsLess, IsStarted, S_digits, N, Memo).