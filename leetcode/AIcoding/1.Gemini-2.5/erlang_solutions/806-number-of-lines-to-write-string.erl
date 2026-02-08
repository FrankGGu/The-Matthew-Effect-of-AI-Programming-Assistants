-module(solution).
-export([lines_to_write_string/2]).

lines_to_write_string(Widths, S) ->
    lines_to_write_string_helper(Widths, S, 1, 0).

lines_to_write_string_helper(_Widths, [], Lines, CurrentLineWidth) ->
    {Lines, CurrentLineWidth};
lines_to_write_string_helper(Widths, [Char | RestS], Lines, CurrentLineWidth) ->
    CharWidth = lists:nth(Char - $a + 1, Widths),

    if
        CurrentLineWidth + CharWidth > 100 ->
            lines_to_write_string_helper(Widths, RestS, Lines + 1, CharWidth);
        true ->
            lines_to_write_string_helper(Widths, RestS, Lines, CurrentLineWidth + CharWidth)
    end.