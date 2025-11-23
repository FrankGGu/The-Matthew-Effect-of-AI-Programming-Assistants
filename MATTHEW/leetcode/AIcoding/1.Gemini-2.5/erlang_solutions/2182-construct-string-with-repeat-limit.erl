-module(solution).
-export([largest_alphanumeric_string/2]).

initialize_counts(S) ->
    Counts = array:new({size, 26}, {default, 0}),
    lists:foldl(fun(Char, AccCounts) ->
                        Idx = Char - $a,
                        array:set(Idx, array:get(Idx, AccCounts) + 1, AccCounts)
                end, Counts, S).

find_char_idx(Counts, StartIdx) ->
    if
        StartIdx < 0 -> -1;
        array:get(StartIdx, Counts) > 0 -> StartIdx;
        true -> find_char_idx(Counts, StartIdx - 1)
    end.

largest_alphanumeric_string(S, RepeatLimit) ->
    InitialCounts = initialize_counts(S),
    %% State: Acc (accumulator for the result string, built in reverse),
    %% Counts (current char counts),
    %% LastChar (the character last appended),
    %% LastCharRepeatCount (consecutive repeats of LastChar),
    %% RepeatLimit (the problem's limit)
    build([], InitialCounts, 0, 0, RepeatLimit). %% 0 for LastChar is a sentinel value

build(Acc, Counts, LastChar, LastCharRepeatCount, Limit) ->
    %% Find the largest character C1 available (from 'z' down to 'a')
    C1Idx = find_char_idx(Counts, 25),

    case C1Idx of
        -1 -> %% No more characters left, return reversed accumulator
            lists:reverse(Acc);
        _ ->
            C1 = C1Idx + $a,
            C1Count = array:get(C1Idx, Counts),

            %% Case 1: C1 is the same as LastChar, and it has already reached the repeat limit
            if
                C1 == LastChar andalso LastCharRepeatCount == Limit ->
                    %% We cannot append C1. We must find a smaller character C2.
                    C2Idx = find_char_idx(Counts, C1Idx - 1),
                    case C2Idx of
                        -1 -> %% No smaller character C2 available. We are done.
                            lists:reverse(Acc);
                        _ ->
                            C2 = C2Idx + $a,
                            %% Append C2 once
                            NewAcc = [C2 | Acc],
                            NewCounts = array:set(C2Idx, array:get(C2Idx, Counts) - 1, Counts),
                            %% After appending C2, reset LastChar and LastCharRepeatCount for C2
                            %% Then, in the next iteration, C1 can be considered again.
                            build(NewAcc, NewCounts, C2, 1, Limit)
                    end;
                true -> %% C1 can be appended (either it's a new char, or its repeat count is below limit)
                    %% Determine how many times C1 can be appended
                    NumToAppend = if
                                      C1 == LastChar -> min(C1Count, Limit - LastCharRepeatCount);
                                      true -> min(C1Count, Limit)
                                  end,

                    %% NumToAppend must be > 0 here because if it were 0, it would mean
                    %% C1 == LastChar and LastCharRepeatCount == Limit, which is handled
                    %% by the first 'if' branch.
                    NewAcc = lists:duplicate(NumToAppend, C1) ++ Acc,
                    NewCounts = array:set(C1Idx, C1Count - NumToAppend, Counts),
                    NewLastCharRepeatCount = if
                                                 C1 == LastChar -> LastCharRepeatCount + NumToAppend;
                                                 true -> NumToAppend
                                             end,
                    build(NewAcc, NewCounts, C1, NewLastCharRepeatCount, Limit)
            end
    end.