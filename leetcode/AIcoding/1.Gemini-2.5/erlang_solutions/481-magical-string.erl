-module(solution).
-export([magicalString/1]).

magicalString(N) when N =< 0 -> 0;
magicalString(N) when N =:= 1 -> 1;
magicalString(N) ->
    % Initialize the array. The string starts with [1, 2, 2].
    % The array size needs to be at least 3 to hold initial elements, or N if N > 3.
    Arr = array:new([{size, max(3, N)}, {fixed, true}, {default, 0}]),

    % Set initial values: S[0]=1, S[1]=2, S[2]=2
    Arr1 = array:set(0, 1, Arr),
    Arr2 = array:set(1, 2, Arr1),
    Arr3 = array:set(2, 2, Arr2),

    % Pointers for string generation
    HeadPtr = 1, % Reads the value at this index to determine how many times to append
    TailPtr = 3, % Points to the next available position to write

    % The number to append (alternates between 1 and 2)
    CurrentNum = 1,

    % Build the magical string up to length N
    ResultArr = build_string(Arr3, HeadPtr, TailPtr, CurrentNum, N),

    % Count '1's in the first N characters of the generated string
    count_ones(ResultArr, N, 0, 0).

build_string(AccArr, Head, Tail, NextNum, N) when Tail >= N ->
    AccArr; % String is long enough
build_string(AccArr, Head, Tail, NextNum, N) ->
    Count = array:get(Head, AccArr), % Get the count from the head pointer's value

    % Append NextNum 'Count' times, ensuring not to write beyond N-1
    NewAccArr = append_chars(AccArr, Tail, Count, NextNum, N),

    % Update pointers and the number to append for the next iteration
    NewHead = Head + 1,
    NewTail = Tail + Count,
    NewNextNum = case NextNum of 1 -> 2; 2 -> 1 end,

    build_string(NewAccArr, NewHead, NewTail, NewNextNum, N).

append_chars(AccArr, StartIdx, Count, Value, N) ->
    append_chars_rec(AccArr, StartIdx, Count, Value, N).

append_chars_rec(AccArr, CurrentIdx, RemainingCount, _Value, N) when CurrentIdx >= N; RemainingCount =< 0 ->
    AccArr;
append_chars_rec(AccArr, CurrentIdx, RemainingCount, Value, N) ->
    NewAccArr = array:set(CurrentIdx, Value, AccArr),
    append_chars_rec(NewAccArr, CurrentIdx + 1, RemainingCount - 1, Value, N).

count_ones(AccArr, N, Idx, Count) when Idx >= N ->
    Count;
count_ones(AccArr, N, Idx, Count) ->
    Val = array:get(Idx, AccArr),
    NewCount = case Val of 1 -> Count + 1; _ -> Count end,
    count_ones(AccArr, N, Idx + 1, NewCount).