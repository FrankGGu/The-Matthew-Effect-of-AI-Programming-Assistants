%% Forward declaration of guess API.
%% @param num   your guess
%% @return      -1 if num is higher than the picked number
%%              1 if num is lower than the picked number
%%              otherwise return 0
%% -spec guess(integer()) -> integer().

-spec guess_number(N :: integer()) -> integer().
guess_number(N) -> guess_number(1, N).

guess_number(Low, High) when Low <= High ->
    Mid = (Low + High) div 2,
    case guess(Mid) of
        0 -> Mid;
        -1 -> guess_number(Low, Mid - 1);
        1 -> guess_number(Mid + 1, High)
    end.
