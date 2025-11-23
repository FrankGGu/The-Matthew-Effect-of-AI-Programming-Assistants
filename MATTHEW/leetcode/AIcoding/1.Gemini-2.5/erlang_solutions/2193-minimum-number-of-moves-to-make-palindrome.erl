-module(solution).
-export([minimum_moves_to_make_palindrome/1]).

minimum_moves_to_make_palindrome(S) ->
    StrList = string:to_list(S),
    N = length(StrList),
    InitialArray = array:from_list(StrList), % 0-indexed array
    solve(InitialArray, 0, N - 1, 0).

solve(Arr, Left, Right, Moves) when Left >= Right ->
    Moves;
solve(Arr, Left, Right, Moves) ->
    CharLeft = array:get(Left, Arr),
    CharRight = array:get(Right, Arr),

    if CharLeft == CharRight ->
        solve(Arr, Left + 1, Right - 1, Moves);
    true ->
        % Find the matching character for CharLeft from Right-1 down to Left+1
        K = find_k(CharLeft, Left + 1, Right - 1, Arr),

        % Move element at K to Right by shifting elements K+1 to Right one position left
        % and placing CharLeft (which was at K) at Right.
        % This involves (Right - K) swaps.

        NewArr = shift_elements(K, Right, Arr),

        solve(NewArr, Left + 1, Right - 1, Moves + (Right - K))
    end.

find_k(TargetChar, CurrentIdx, EndIdx, Arr) when CurrentIdx =< EndIdx ->
    Char = array:get(CurrentIdx, Arr),
    if Char == TargetChar ->
        CurrentIdx;
    true ->
        find_k(TargetChar, CurrentIdx + 1, EndIdx, Arr)
    end.

shift_elements(K, Right, Arr) ->
    CharToMove = array:get(K, Arr),
    ShiftedArr = shift_elements_recursive_array(K, Right - 1, Arr),
    array:set(Right, CharToMove, ShiftedArr).

shift_elements_recursive_array(CurrentIdx, MaxIdx, AccArr) when CurrentIdx =< MaxIdx ->
    NewAccArr = array:set(CurrentIdx, array:get(CurrentIdx + 1, AccArr), AccArr),
    shift_elements_recursive_array(CurrentIdx + 1, MaxIdx, NewAccArr);
shift_elements_recursive_array(_, _, AccArr) ->
    AccArr.