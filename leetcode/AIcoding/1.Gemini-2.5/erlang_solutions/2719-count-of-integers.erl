-module(solution).
-export([count_integers/4]).

char_list_to_int_list(Cs) -> [C - $0 || C <- Cs].

subtract_one_from_string(NumStr) ->
    N = list_to_integer(NumStr),
    integer_to_list(N - 1).

count_integers(Num1Str, Num2Str, MinSum, MaxSum) ->
    Mod = 1_000_000_007,

    MemoTable = ets:new(digit_dp_memo, [set, protected, {read_concurrency, true}]),

    CountUpToNum2 = solve(Num2Str, MinSum, MaxSum, MemoTable, Mod),

    ets:delete_all_objects(MemoTable),

    CountUpToNum1Minus1 =
        if Num1Str == "0" ->
            0;
        true ->
            solve(subtract_one_from_string(Num1Str), MinSum, MaxSum, MemoTable, Mod)
        end,

    ets:delete(MemoTable),

    (CountUpToNum2 - CountUpToNum1Minus1 + Mod) rem Mod.

solve(S, MinSum, MaxSum, MemoTable, Mod) ->
    Digits = char_list_to_int_list(S),
    Len = length(Digits),

    dp(0, 0, true, true, Digits, Len, MinSum, MaxSum, MemoTable, Mod).

dp(Idx, CurrentSum, _IsTight, _IsLeadingZero, _Digits, Len, MinSum, MaxSum, _MemoTable, _Mod) when Idx == Len ->
    if CurrentSum >= MinSum andalso CurrentSum =< MaxSum ->
        1;
    true ->
        0
    end;
dp(_Idx, CurrentSum, _IsTight, _IsLeadingZero, _Digits, _Len, _MinSum, MaxSum, _MemoTable, _Mod) when CurrentSum > MaxSum ->
    0;
dp(Idx, CurrentSum, IsTight, IsLeadingZero, Digits, Len, MinSum, MaxSum, MemoTable, Mod) ->
    Key = {Idx, CurrentSum, IsTight, IsLeadingZero},
    case ets:lookup(MemoTable, Key) of
        [{Key, Result}] ->
            Result;
        [] ->
            UpperLimit = if IsTight -> lists:nth(Idx + 1, Digits); true -> 9 end,

            Result = lists:foldl(fun(Digit, Acc) ->
                NewIsTight = IsTight andalso (Digit == UpperLimit),
                NewIsLeadingZero = IsLeadingZero andalso (Digit == 0),

                NextSum = if IsLeadingZero andalso (Digit == 0) -> CurrentSum; true -> CurrentSum + Digit end,

                (Acc + dp(Idx + 1, NextSum, NewIsTight, NewIsLeadingZero, Digits, Len, MinSum, MaxSum, MemoTable, Mod)) rem Mod
            end, 0, lists:seq(0, UpperLimit)),

            ets:insert(MemoTable, {Key, Result}),
            Result
    end.