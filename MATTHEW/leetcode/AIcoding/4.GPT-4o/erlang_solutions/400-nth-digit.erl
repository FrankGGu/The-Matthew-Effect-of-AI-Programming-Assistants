-module(solution).
-export([find_nth_digit/1]).

%% Find the nth digit in the infinite integer sequence.
-spec find_nth_digit(integer()) -> integer().
find_nth_digit(N) ->
    find_nth_digit(N, 1, 9, 1).

%% Helper function to calculate the nth digit.
-spec find_nth_digit(integer(), integer(), integer(), integer()) -> integer().
find_nth_digit(N, Start, End, Length) when N > End ->
    find_nth_digit(N - End, Start * 10, End * 10, Length + 1);
find_nth_digit(N, Start, End, Length) ->
    Num = Start + (N - 1) div Length,
    DigitIndex = (N - 1) rem Length,
    lists:nth(DigitIndex + 1, integer_to_list(Num)).

