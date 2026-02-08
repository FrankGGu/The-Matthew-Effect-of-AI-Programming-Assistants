-module(license_key_formatting).
-export([format_license/1]).

format_license(S) ->
    format_license(S, []).

format_license([], Acc) ->
    lists:reverse(Acc);
format_license([C | T], Acc) when C >= $a, C =< $z ->
    format_license(T, [string:to_upper([C]) | Acc]);
format_license([C | T], Acc) when C == $- ->
    format_license(T, Acc);
format_license([C | T], Acc) ->
    format_license(T, [C | Acc]).

format_license_reversed([], _, _) ->
    [];
format_license_reversed([H | T], Count, Result) ->
    case Count rem 4 of
        0 when Count /= 0 ->
            [H | format_license_reversed(T, Count + 1, [$- | Result])];
        _ ->
            [H | format_license_reversed(T, Count + 1, Result)]
    end.

format_license_final([]) ->
    [];
format_license_final([H | T]) ->
    [H | format_license_final(T)].

format_license(S) ->
    Cleaned = format_license(S),
    Reversed = lists:reverse(Cleaned),
    Formatted = format_license_reversed(Reversed, 0, []),
    format_license_final(Formatted).