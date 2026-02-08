-module(cells_in_range).
-export([cells_in_range/1]).

cells_in_range(S) ->
    [StartCol, StartRow | _] = string:tokens(S, ":"),
    [EndCol, EndRow | _] = string:tokens(lists:reverse(S), ":"),

    StartColCharCode = hd(StartCol),
    EndColCharCode = hd(EndCol),

    StartRowInt = list_to_integer(StartRow),
    EndRowInt = list_to_integer(EndRow),

    Result = lists:flatten([
        [
            list_to_binary([ColCharCode, RowInt + $0])
            || RowInt <- lists:seq(0, EndRowInt - StartRowInt)
        ]
        || ColCharCode <- lists:seq(StartColCharCode, EndColCharCode)
    ]),

    Result.