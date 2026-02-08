-module(compare_version_numbers).
-export([compare/2]).

compare(Version1, Version2) ->
    Parts1 = string:split(Version1, ".", all),
    Parts2 = string:split(Version2, ".", all),
    compare_parts(Parts1, Parts2).

compare_parts([], []) -> 0;
compare_parts([], _Parts2) -> -1;
compare_parts(_Parts1, []) -> 1;
compare_parts([H1|T1], [H2|T2]) ->
    Num1 = list_to_integer(H1),
    Num2 = list_to_integer(H2),
    if
        Num1 < Num2 -> -1;
        Num1 > Num2 -> 1;
        true -> compare_parts(T1, T2)
    end.