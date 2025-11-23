-module(solution).
-export([countSpecialIntegers/1]).

countSpecialIntegers(N) ->
    N_digits_list = [C - $0 || C <- integer_to_list(N)],
    N_digits_tuple = list_to_tuple(N_digits_list),
    L = length(N_digits_list),

    InitialMemo = maps:new(),

    %% dp(Index, Tight, Mask, IsLeading, N_digits_tuple, L, Memo)
    %% Index: current digit position (0-based)
    %% Tight: boolean, true if restricted by N's digits
    %% Mask: bitmask of used digits (0-9)
    %% IsLeading: boolean, true if we are currently placing leading zeros
    %% N_digits_tuple: tuple of digits of N
    %% L: length of N_digits_tuple
    %% Memo: map for memoization
    %% Returns {Count, UpdatedMemo}
    {Result, _FinalMemo} = dp(0, true, 0, true, N_digits_tuple, L, InitialMemo),
    Result.

dp(Index, Tight, Mask, IsLeading, N_digits_tuple, L, Memo) ->
    Key = {Index, Tight, Mask, IsLeading},
    case maps:find(Key, Memo) of
        {ok, Val} -> {Val, Memo};
        error ->
            {Ans, UpdatedMemo} = 
                if Index == L ->
                    if IsLeading == true -> {0, Memo}; %% If we reached end and only placed leading zeros, it's not a valid number (e.g., 000)
                       true -> {1, Memo} %% Valid number found
                    end;
                   true ->
                    Upper = if Tight == true then element(Index + 1, N_digits_tuple) else 9 end,

                    loop_digits(0, Upper, Index, Tight, Mask, IsLeading, N_digits_tuple, L, Memo)
                end,
            {Ans, maps:put(Key, Ans, UpdatedMemo)}
    end.

loop_digits(CurrentDigit, Upper, _Index, _Tight, _Mask, _IsLeading, _N_digits_tuple, _L, Memo) when CurrentDigit > Upper ->
    {0, Memo};
loop_digits(CurrentDigit, Upper, Index, Tight, Mask, IsLeading, N_digits_tuple, L, Memo) ->
    {SubAns, MemoAfterSubCall} = 
        if IsLeading == true andalso CurrentDigit == 0 ->
            %% Still placing leading zeros. Mask doesn't change, IsLeading remains true.
            dp(Index + 1, Tight and (CurrentDigit == Upper), Mask, true, N_digits_tuple, L, Memo);
           (Mask band (1 bsl CurrentDigit)) == 0 ->
            %% Not a leading zero, or it's the first non-zero digit, and digit is not used
            NewTight = Tight and (CurrentDigit == Upper),
            NewMask = Mask bor (1 bsl CurrentDigit),
            dp(Index + 1, NewTight, NewMask, false, N_digits_tuple, L, Memo);
           true ->
            %% Digit already used
            {0, Memo}
        end,

    {NextLoopAns, FinalMemo} = loop_digits(CurrentDigit + 1, Upper, Index, Tight, Mask, IsLeading, N_digits_tuple, L, MemoAfterSubCall),

    {SubAns + NextLoopAns, FinalMemo}.