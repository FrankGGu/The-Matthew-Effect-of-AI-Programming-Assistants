-module(solution).
-export([max_score/1]).

max_score(S) ->
    % Calculate the total number of '1's in the entire string.
    TotalOnes = lists:foldl(fun(C, Acc) ->
                                if C == $1 -> Acc + 1;
                                   true -> Acc
                                end
                            end, 0, S),

    % Split the string into its first character (Head) and the rest (Tail).
    [H | T] = S,

    % Initialize counts for the first possible split:
    % The left part contains only the first character (H).
    % The right part contains the rest of the string (T).
    ZerosInLeft = if H == $0 -> 1; true -> 0 end,
    OnesInRight = if H == $1 -> TotalOnes - 1; true -> TotalOnes end,

    % The maximum score found so far is initially the score of the first split.
    MaxScore = ZerosInLeft + OnesInRight,

    % Prepare the list of characters to iterate through.
    % These characters will be moved one by one from the right part to the left part.
    % We stop before the last character of the original string to ensure the right part is always non-empty.
    % `lists:droplast(T)` effectively processes characters from S[2] up to S[Length-1].
    T_to_process = lists:droplast(T),

    % Use `lists:foldl` to iterate through `T_to_process`, updating counts and tracking the maximum score.
    % The accumulator is a tuple: {CurrentZerosInLeft, CurrentOnesInRight, CurrentMaxScore}.
    {_FinalZerosInLeft, _FinalOnesInRight, FinalMaxScore} = 
        lists:foldl(fun(Char, {AccZerosInLeft, AccOnesInRight, AccMaxScore}) ->
                        % Update the count of zeros in the left part.
                        NewZerosInLeft = if Char == $0 -> AccZerosInLeft + 1; true -> AccZerosInLeft end,
                        % Update the count of ones in the right part (by removing Char if it's a '1').
                        NewOnesInRight = if Char == $1 -> AccOnesInRight - 1; true -> AccOnesInRight end,

                        % Calculate the score for the current split.
                        CurrentScore = NewZerosInLeft + NewOnesInRight,

                        % Update the maximum score found so far.
                        {NewZerosInLeft, NewOnesInRight, max(AccMaxScore, CurrentScore)}
                    end, {ZerosInLeft, OnesInRight, MaxScore}, T_to_process),

    FinalMaxScore.