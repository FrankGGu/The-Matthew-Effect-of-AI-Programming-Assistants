-module(balanced_strings).
-export([balanced_string_split/1]).

balanced_string_split(Str) ->
    balanced_string_split(Str, 0, 0).

balanced_string_split([], _, Count) ->
    Count;
balanced_string_split([H | T], Balance, Count) ->
    case H of
        $L -> balanced_string_split(T, Balance + 1, Count);
        $R -> balanced_string_split(T, Balance - 1, Count);
        _ -> balanced_string_split(T, Balance, Count)
    end,
    if
        Balance == 0 -> balanced_string_split(T, 0, Count + 1);
        true -> balanced_string_split(T, Balance, Count)
    end.