-module(take_k_each_character).
-export([take_k_of_each_character_from_left_and_right/2]).

take_k_of_each_character_from_left_and_right(S, K) ->
    Len = length(S),
    Counts = count_chars(S),
    if
        Counts#a < K orelse Counts#b < K orelse Counts#c < K ->
            -1;
        true ->
            take_k_of_each_character_from_left_and_right_helper(S, K, Len)
    end.

take_k_of_each_character_from_left_and_right_helper(S, K, Len) ->
    take_k_of_each_character_from_left_and_right_helper(S, K, Len, 0, Len - 1, Len).

take_k_of_each_character_from_left_and_right_helper(S, K, Len, L, R, MinLen) ->
    if
        L > R ->
            MinLen;
        true ->
            Counts = count_chars(sublist(S, R+1, Len - R) ++ sublist(S, 1, L)),
            if
                Counts#a >= K and Counts#b >= K and Counts#c >= K ->
                    NewLen = R - L + 1,
                    take_k_of_each_character_from_left_and_right_helper(S, K, Len, L + 1, R - 1, min(MinLen, NewLen));
                true ->
                    MinLen
            end
    end.

count_chars(S) ->
    count_chars(S, #{}, 0).

count_chars([], Counts, _) ->
    Counts#a := proplists:get_value('a', Counts, 0),
    Counts#b := proplists:get_value('b', Counts, 0),
    Counts#c := proplists:get_value('c', Counts, 0),
    Counts;
count_chars([H|T], Counts, I) ->
    Key = list_to_atom([H]),
    NewCounts = Counts#{Key => proplists:get_value(Key, Counts, 0) + 1},
    count_chars(T, NewCounts, I + 1).

sublist(L, Start, Length) ->
    lists:sublist(L, Start, Length).