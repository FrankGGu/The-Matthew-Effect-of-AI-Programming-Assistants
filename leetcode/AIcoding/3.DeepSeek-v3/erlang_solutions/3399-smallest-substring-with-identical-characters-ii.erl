-module(solution).
-export([smallest_substring/1]).

smallest_substring(S) ->
    case S of
        [] -> "";
        _ ->
            {MinLen, Start, End} = find_min_substring(S, 0, 0, length(S), 0, 0),
            string:sub_string(S, Start + 1, End)
    end.

find_min_substring(S, Left, Right, MinLen, MinStart, MinEnd) when Right < length(S) ->
    case is_valid(S, Left, Right) of
        true ->
            CurrentLen = Right - Left + 1,
            if
                CurrentLen < MinLen ->
                    find_min_substring(S, Left, Right + 1, CurrentLen, Left, Right);
                true ->
                    find_min_substring(S, Left, Right + 1, MinLen, MinStart, MinEnd)
            end;
        false ->
            find_min_substring(S, Left + 1, Right, MinLen, MinStart, MinEnd)
    end;
find_min_substring(_S, Left, Right, MinLen, MinStart, MinEnd) when Left =< Right ->
    find_min_substring(_S, Left + 1, Right, MinLen, MinStart, MinEnd);
find_min_substring(_S, _Left, _Right, MinLen, MinStart, MinEnd) ->
    {MinLen, MinStart, MinEnd}.

is_valid(S, Left, Right) ->
    Char = string:sub_string(S, Left + 1, Left + 1),
    lists:all(fun(I) -> string:sub_string(S, I + 1, I + 1) == Char end, lists:seq(Left, Right)).