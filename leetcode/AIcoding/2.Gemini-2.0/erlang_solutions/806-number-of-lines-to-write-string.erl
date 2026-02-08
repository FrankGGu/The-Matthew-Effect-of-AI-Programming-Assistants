-module(number_of_lines).
-export([number_of_lines/2]).

number_of_lines(Widths, S) ->
    number_of_lines_helper(Widths, S, 1, 0).

number_of_lines_helper(Widths, [], Lines, CurrentWidth) ->
    {Lines, CurrentWidth};
number_of_lines_helper(Widths, [Char | Rest], Lines, CurrentWidth) ->
    Width = lists:nth(Char - $a + 1, Widths),
    case CurrentWidth + Width > 100 of
        true ->
            number_of_lines_helper(Widths, [Char | Rest], Lines + 1, Width);
        false ->
            number_of_lines_helper(Widths, Rest, Lines, CurrentWidth + Width)
    end.