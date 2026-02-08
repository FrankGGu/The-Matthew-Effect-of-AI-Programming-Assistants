-module(solution).
-export([is_valid_tic_tac_toe/1]).

count_char(Board, Char) ->
    lists:sum([lists:sum([if C == Char -> 1; true -> 0 end || C <- Row]) || Row <- Board]).

check_win(Board, Char) ->
    [R1, R2, R3] = Board,
    [C11, C12, C13] = R1,
    [C21, C22, C23] = R2,
    [C31, C32, C33] = R3,

    (R1 == [Char, Char, Char]) orelse
    (R2 == [Char, Char, Char]) orelse
    (R3 == [Char, Char, Char]) orelse
    ([C11, C21, C31] == [Char, Char, Char]) orelse
    ([C12, C22, C32] == [Char, Char, Char]) orelse
    ([C13, C23, C33] == [Char, Char, Char]) orelse
    ([C11, C22, C33] == [Char, Char, Char]) orelse
    ([C13, C22, C31] == [Char, Char, Char]).

is_valid_tic_tac_toe(Board) ->
    X_count = count_char(Board, $X),
    O_count = count_char(Board, $O),

    X_wins = check_win(Board, $X),
    O_wins = check_win(Board, $O),

    if
        X_count < O_count -> false;
        X_count > O_count + 1 -> false;
        true ->
            if
                X_wins andalso O_wins -> false;
                X_wins andalso (X_count == O_count) -> false;
                O_wins andalso (X_count > O_count) -> false;
                true -> true
            end
    end.