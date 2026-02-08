-module(find_special_substring).
-export([find_special_substrings/2]).

find_special_substrings(S, K) ->
    find_special_substrings(S, K, []).

find_special_substrings(S, K, Acc) ->
    Len = length(S),
    if Len < K then
        lists:reverse(Acc)
    else
        Sub = lists:sublist(S, K),
        if is_special(Sub) then
            NewAcc = [list_to_binary(Sub) | Acc],
            find_special_substrings(tl(S), K, NewAcc)
        else
            find_special_substrings(tl(S), K, Acc)
        end
    end.

is_special(Sub) ->
    is_special(Sub, []).

is_special([], _) ->
    true;
is_special([H|T], Seen) ->
    case lists:member(H, Seen) of
        true ->
            false;
        false ->
            is_special(T, [H|Seen])
    end.