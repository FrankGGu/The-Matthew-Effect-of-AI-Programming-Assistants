-module(solution).
-export([max_freq/4]).

max_freq(S, MaxLetters, MinSize, _MaxSize) ->
    % Convert string to binary for efficient substring operations (O(1) part extraction)
    BinS = list_to_binary(S),
    LenS = byte_size(BinS),

    % If the string length is less than MinSize, no valid substrings can be formed.
    % Constraints state 1 <= minSize <= S.length, but defensive check is good.
    if
        LenS < MinSize -> 0;
        true ->
            % Initial state for the sliding window:
            % CharFreqMap: map of character -> count in the current window
            % UniqueCount: number of unique characters in the current window
            % SubFreqMap: map of valid substring binary -> its frequency
            % MaxFreq: maximum frequency found so far
            InitialCharFreqMap = #{},
            InitialUniqueCount = 0,
            InitialSubFreqMap = #{},
            InitialMaxFreq = 0,

            % Build the first window (from index 0 to MinSize-1)
            % This function populates CharFreqMap and UniqueCount for the first window.
            {CharFreqMap1, UniqueCount1} =
                build_initial_window(BinS, 0, MinSize - 1, InitialCharFreqMap, InitialUniqueCount),

            % Process the first window to check its validity and update SubFreqMap and MaxFreq.
            {SubFreqMap2, MaxFreq2} =
                process_window(BinS, 0, MinSize, MaxLetters, UniqueCount1, InitialSubFreqMap, InitialMaxFreq),

            % Slide the window from the next starting index (1) up to LenS - MinSize.
            % The loop iterates through the starting index of each window.
            % A window starts at 'StartIdx' and ends at 'StartIdx + MinSize - 1'.
            slide_window(BinS, 1, LenS - MinSize, MinSize, MaxLetters,
                         CharFreqMap1, UniqueCount1, SubFreqMap2, MaxFreq2)
    end.

build_initial_window(BinS, Idx, EndIdx, CharFreqMap, UniqueCount) ->
    if
        Idx > EndIdx ->
            {CharFreqMap, UniqueCount};
        true ->
            Char = binary:at(BinS, Idx), % Get character at current index
            CurrentCharCount = maps:get(Char, CharFreqMap, 0),
            NewCharFreqMap = maps:put(Char, CurrentCharCount + 1, CharFreqMap),
            NewUniqueCount = if
                                 CurrentCharCount == 0 -> UniqueCount + 1; % New unique character
                                 true -> UniqueCount
                             end,
            build_initial_window(BinS, Idx + 1, EndIdx, NewCharFreqMap, NewUniqueCount)
    end.

process_window(BinS, StartIdx, MinSize, MaxLetters, UniqueCount, SubFreqMap, MaxFreq) ->
    if
        UniqueCount =< MaxLetters ->
            SubBin = binary:part(BinS, StartIdx, MinSize), % Extract substring binary
            CurrentSubCount = maps:get(SubBin, SubFreqMap, 0) + 1,
            NewSubFreqMap = maps:put(SubBin, CurrentSubCount, SubFreqMap),
            NewMaxFreq = max(MaxFreq, CurrentSubCount),
            {NewSubFreqMap, NewMaxFreq};
        true ->
            % Not a valid substring, return current state unchanged
            {SubFreqMap, MaxFreq}
    end.

slide_window(BinS, StartIdx, MaxStartIdx, MinSize, MaxLetters,
             CharFreqMap, UniqueCount, SubFreqMap, MaxFreq) ->
    if
        StartIdx > MaxStartIdx ->
            MaxFreq; % All windows processed, return the final maximum frequency
        true ->
            % Character leaving the window (at StartIdx - 1)
            CharToRemove = binary:at(BinS, StartIdx - 1),
            CurrentCharCountRemove = maps:get(CharToRemove, CharFreqMap),
            NewCharFreqMap1 = maps:put(CharToRemove, CurrentCharCountRemove - 1, CharFreqMap),
            NewUniqueCount1 = if
                                  CurrentCharCountRemove - 1 == 0 -> UniqueCount - 1; % Char is no longer in window
                                  true -> UniqueCount
                              end,

            % Character entering the window (at StartIdx + MinSize - 1)
            CharToAdd = binary:at(BinS, StartIdx + MinSize - 1),
            CurrentCharCountAdd = maps:get(CharToAdd, NewCharFreqMap1, 0),
            NewCharFreqMap2 = maps:put(CharToAdd, CurrentCharCountAdd + 1, NewCharFreqMap1),
            NewUniqueCount2 = if
                                  CurrentCharCountAdd == 0 -> NewUniqueCount1 + 1; % New unique char added
                                  true -> NewUniqueCount1
                              end,

            % Process the newly formed window
            {NewSubFreqMap, NewMaxFreq} =
                process_window(BinS, StartIdx, MinSize, MaxLetters, NewUniqueCount2, SubFreqMap, MaxFreq),

            % Recurse for the next window
            slide_window(BinS, StartIdx + 1, MaxStartIdx, MinSize, MaxLetters,
                         NewCharFreqMap2, NewUniqueCount2, NewSubFreqMap, NewMaxFreq)
    end.