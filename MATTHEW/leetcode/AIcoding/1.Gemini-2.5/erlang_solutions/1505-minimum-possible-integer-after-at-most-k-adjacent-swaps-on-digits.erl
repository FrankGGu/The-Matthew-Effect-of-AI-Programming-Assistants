-module(solution).
-export([minInteger/2]).

bit_new(Size) ->
    array:new([{size, Size + 1}, {fixed, true}, {default, 0}]).

bit_update(Bit, Idx, Val) ->
    bit_update_loop(Bit, Idx, Val, array:size(Bit) - 1).

bit_update_loop(Bit, Idx, Val, MaxIdx) ->
    if Idx =< MaxIdx ->
        NewBit = array:set(Idx, array:get(Idx, Bit) + Val, Bit),
        bit_update_loop(NewBit, Idx + (Idx band -Idx), Val, MaxIdx);
    true ->
        Bit
    end.

bit_query(Bit, Idx) ->
    bit_query_loop(Bit, Idx, 0).

bit_query_loop(Bit, Idx, Sum) ->
    if Idx > 0 ->
        NewSum = Sum + array:get(Idx, Bit),
        bit_query_loop(Bit, Idx - (Idx band -Idx), NewSum);
    true ->
        Sum
    end.

minInteger(NumStr, K) ->
    N = length(NumStr),

    %% Initialize Fenwick tree with all elements present (value 1)
    InitialBit = bit_new(N),
    FenwickTree0 = lists:foldl(fun(Idx, AccBit) -> bit_update(AccBit, Idx, 1) end, InitialBit, lists:seq(1, N)),

    %% Store original 1-indexed positions of each digit
    %% DigitPositions is an array of lists. DigitPositions[D] = [pos1, pos2, ...]
    %% We prepend indices and then reverse the lists to maintain sorted order efficiently.
    DigitPositions0 = array:new([{size, 10}, {fixed, true}, {default, []}]),
    {PreReverseDigitPositions, _} = lists:foldl(
        fun(Char, {AccDP, Idx}) ->
            Digit = Char - $0, %% Convert char to integer digit
            CurrentList = array:get(Digit, AccDP),
            NewList = [Idx | CurrentList], %% Prepend to build list in reverse order
            {array:set(Digit, NewList, AccDP), Idx + 1}
        end,
        {DigitPositions0, 1},
        NumStr
    ),
    %% Reverse each list to get original indices in ascending order
    FinalDigitPositions = array:map(fun(_Digit, List) -> lists:reverse(List) end, PreReverseDigitPositions),

    %% Build the result string
    lists:flatten(lists:reverse(min_integer_loop(N, K, 0, FenwickTree0, FinalDigitPositions, []))).

min_integer_loop(N, K, CurrentTargetPos, FenwickTree, DigitPositions, AccResult) ->
    if CurrentTargetPos >= N ->
        AccResult; %% Return the accumulated list of char lists
    true ->
        %% Try to find the smallest digit (0-9)
        find_and_swap_digit(0, K, CurrentTargetPos, FenwickTree, DigitPositions, AccResult, N)
    end.

find_and_swap_digit(Digit, K, CurrentTargetPos, FenwickTree, DigitPositions, AccResult, N) ->
    if Digit > 9 ->
        %% This case should not be reached if CurrentTargetPos < N,
        %% as there must be some digit available to fill the position.
        error(no_digit_found);
    true ->
        Positions = array:get(Digit, DigitPositions),
        if Positions =:= [] ->
            %% No more occurrences of this digit, try next digit
            find_and_swap_digit(Digit + 1, K, CurrentTargetPos, FenwickTree, DigitPositions, AccResult, N);
        true ->
            OriginalIdx = hd(Positions), %% Get the smallest original index for this digit
            CurrentEffectivePos = bit_query(FenwickTree, OriginalIdx) - 1, %% 0-indexed current position among available digits
            Cost = CurrentEffectivePos - CurrentTargetPos,

            if Cost =< K ->
                %% Found the smallest digit that can be moved to CurrentTargetPos
                NewK = K - Cost,
                NewFenwickTree = bit_update(FenwickTree, OriginalIdx, -1), %% Mark this digit as used
                NewDigitPositions = array:set(Digit, tl(Positions), DigitPositions), %% Remove from available positions
                NewAccResult = [integer_to_list(Digit) | AccResult], %% Add digit to result (as a char list)
                min_integer_loop(N, NewK, CurrentTargetPos + 1, NewFenwickTree, NewDigitPositions, NewAccResult);
            true ->
                %% This digit is too far to move with current K, try next digit
                find_and_swap_digit(Digit + 1, K, CurrentTargetPos, FenwickTree, DigitPositions, AccResult, N)
            end
        end
    end.