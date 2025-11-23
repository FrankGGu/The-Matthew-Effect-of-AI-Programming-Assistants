-module(solution).
-export([wordsTyping/3]).

wordsTyping(Sentence, Rows, Cols) ->
    NumWords = length(Sentence),
    WordLengths = [length(Word) || Word <- Sentence],

    % Memoization table: array of {NextWordIdx, SentencesCompleted}
    % Initialized with undefined. Size NumWords.
    Memo = array:new(NumWords, {default, undefined}),

    % Function to calculate how many words fit on a line starting with StartWordIdx
    % and how many sentences are completed.
    % It also uses and updates the Memo table.
    % Returns {NextWordIdx, SentencesCompletedOnLine, UpdatedMemo}
    calculate_line_fit(StartWordIdx, CurrentCols, WL, NW, AccMemo) ->
        case array:get(StartWordIdx, AccMemo) of
            undefined ->
                % Simulate fitting words for one line
                % WIdx: current word index (0-indexed)
                % CCL: current length used on the line
                % SC: number of full sentences completed on current line
                FitLoop = 
                    fun FLL(WIdx, CCL, SC) ->
                        WordLen = lists:nth(WIdx + 1, WL), % lists:nth is 1-indexed

                        if CCL + WordLen =< CurrentCols ->
                            NewCCL = CCL + WordLen,
                            NewWIdx = (WIdx + 1) rem NW,
                            NewSC = 
                                if NewWIdx == 0 -> SC + 1;
                                true -> SC
                                end,

                            % Check if a space can fit after the word
                            if NewCCL + 1 =< CurrentCols ->
                                FLL(NewWIdx, NewCCL + 1, NewSC);
                            true -> % No space, this word is the last on the line
                                {NewWIdx, NewSC}
                            end;
                        true -> % Current word doesn't fit
                            {WIdx, SC}
                        end
                    end,

                {NextWordIdx, SentencesOnLine} = FitLoop(StartWordIdx, 0, 0),
                NewMemo = array:set(StartWordIdx, {NextWordIdx, SentencesOnLine}, AccMemo),
                {NextWordIdx, SentencesOnLine, NewMemo};

            {NextWordIdx, SentencesOnLine} ->
                {NextWordIdx, SentencesOnLine, AccMemo}
        end,

    % Main loop to iterate through rows
    % CurrentRow: current row number
    % TotalRows: total rows
    % CurrentWordIdx: starting word index for the current row
    % TotalSentences: accumulated count of full sentences
    % Memo: memoization table
    main_loop(CurrentRow, TotalRows, CurrentWordIdx, TotalSentences, AccMemo) ->
        if CurrentRow > TotalRows ->
            TotalSentences;
        true ->
            {NextWordIdx, SentencesOnLine, UpdatedMemo} = 
                calculate_line_fit(CurrentWordIdx, Cols, WordLengths, NumWords, AccMemo),
            main_loop(CurrentRow + 1, TotalRows, NextWordIdx, TotalSentences + SentencesOnLine, UpdatedMemo)
        end.

    main_loop(1, Rows, 0, 0, Memo).