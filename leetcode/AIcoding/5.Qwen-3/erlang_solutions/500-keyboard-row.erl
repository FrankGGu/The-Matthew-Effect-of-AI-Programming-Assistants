-module(keyboard_row).
-export([find_keyboard_rows/1]).

find_keyboard_rows(Words) ->
    Rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"],
    [Word || Word <- Words, is_in_one_row(Word, Rows)].

is_in_one_row([], _) -> true;
is_in_one_row([C | Rest], Rows) ->
    LowerC = string:to_lower([C]),
    Row = find_row(LowerC, Rows),
    case Row of
        false -> false;
        _ -> is_in_one_row(Rest, Rows)
    end.

find_row(_, []) -> false;
find_row(Char, [Row | Rest]) ->
    case string:contains(Row, Char) of
        true -> Row;
        _ -> find_row(Char, Rest)
    end.