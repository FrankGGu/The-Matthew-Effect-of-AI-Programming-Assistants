-module(solution).
-export([count_substrings/1]).

count_substrings(List) ->
    LastDigit = hd(lists:reverse(List)),
    Count = count_substrings_helper(List, LastDigit, 0, 0),
    Count.

count_substrings_helper([], _, Count, _) -> Count;
count_substrings_helper([H | T], LastDigit, Count, Current) ->
    NewCurrent = Current * 10 + H,
    NewCount = if 
        LastDigit =:= 0 -> Count; 
        (NewCurrent rem LastDigit) =:= 0 -> count_substrings_helper(T, LastDigit, Count + 1, NewCurrent); 
        true -> count_substrings_helper(T, LastDigit, Count, NewCurrent)
    end,
    NewCount.