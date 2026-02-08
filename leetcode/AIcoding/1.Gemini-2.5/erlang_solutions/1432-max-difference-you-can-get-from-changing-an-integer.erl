-module(solution).
-export([max_diff/1]).

max_diff(Num) ->
    NumStr = integer_to_list(Num),
    MaxVal = calculate_max_val(NumStr),
    MinVal = calculate_min_val(NumStr),
    MaxVal - MinVal.

calculate_max_val(NumStr) ->
    case find_first_non_char(NumStr, $9) of
        none ->
            list_to_integer(NumStr);
        OldChar ->
            NewStr = replace_char(NumStr, OldChar, $9),
            list_to_integer(NewStr)
    end.

calculate_min_val(NumStr) ->
    [FirstChar | _] = NumStr,
    case FirstChar of
        $1 ->
            case find_first_non_chars(NumStr, [$0, $1]) of
                none ->
                    list_to_integer(NumStr);
                OldChar ->
                    NewStr = replace_char(NumStr, OldChar, $0),
                    list_to_integer(NewStr)
            end;
        _ ->
            NewStr = replace_char(NumStr, FirstChar, $1),
            list_to_integer(NewStr)
    end.

find_first_non_char([], _) -> none;
find_first_non_char([H | T], CharToAvoid) when H == CharToAvoid ->
    find_first_non_char(T, CharToAvoid);
find_first_non_char([H | _], _) -> H.

find_first_non_chars([], _) -> none;
find_first_non_chars([H | T], CharsToAvoid) when lists:member(H, CharsToAvoid) ->
    find_first_non_chars(T, CharsToAvoid);
find_first_non_chars([H | _], _) -> H.

replace_char([], _, _) -> [];
replace_char([H | T], OldChar, NewChar) when H == OldChar ->
    [NewChar | replace_char(T, OldChar, NewChar)];
replace_char([H | T], OldChar, NewChar) ->
    [H | replace_char(T, OldChar, NewChar)].