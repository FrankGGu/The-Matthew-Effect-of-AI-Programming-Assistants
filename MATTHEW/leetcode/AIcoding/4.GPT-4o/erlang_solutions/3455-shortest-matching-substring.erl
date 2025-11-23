-module(shortest_matching_substring).
-export([min_window/2]).

min_window(S, T) ->
    SLen = length(S),
    TLen = length(T),
    if
        SLen < TLen -> ""
    end,
    CharCount = count_chars(T),
    min_window_helper(S, CharCount, #{}).

min_window_helper([], _, Acc) ->
    if maps:is_empty(Acc) -> "" end;
min_window_helper(Str, CharCount, Acc) ->
    case find_window(Str, CharCount, Acc, 0, 0, length(Str)) of
        {Min, Start, End} -> substring(Str, Start, End);
        _ -> ""
    end.

find_window(Str, CharCount, Acc, Start, End, Min) ->
    case get_char(Str, End) of
        none -> {Min, Start, End};
        Char ->
            NewAcc = update_acc(Acc, Char, 1),
            if maps:is_empty(NewAcc) -> 
                NewMin = min(Min, End - Start + 1),
                find_window(Str, CharCount, NewAcc, Start, End + 1, NewMin);
            true -> 
                find_window(Str, CharCount, NewAcc, Start, End + 1, Min)
            end
    end.

get_char(Str, Index) ->
    case lists:nth(Index + 1, Str) of
        Char when is_list(Char) -> Char;
        _ -> none
    end.

update_acc(Acc, Char, Count) ->
    case maps:is_key(Char, Acc) of
        true -> maps:update(Char, fun(X) -> X + Count end, Acc);
        false -> maps:put(Char, Count, Acc)
    end.

count_chars(T) ->
    lists:foldl(fun(Char, Acc) -> update_acc(Acc, Char, 1) end, #{}, T).

substring(Str, Start, End) ->
    lists:sublist(Str, Start + 1, End - Start + 1).