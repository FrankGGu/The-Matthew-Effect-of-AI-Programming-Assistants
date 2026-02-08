-module(count_unique_characters).
-export([count_unique_chars/1]).

count_unique_chars(S) ->
    N = length(S),
    count_unique_chars_helper(S, N, 0).

count_unique_chars_helper(_S, 0, Acc) ->
    Acc;
count_unique_chars_helper(S, N, Acc) ->
    count_unique_chars_helper(S, N - 1, Acc + sum_unique_chars(S, N)).

sum_unique_chars(S, Len) ->
    sum_unique_chars_helper(S, Len, 0, 0).

sum_unique_chars_helper(_S, _Len, Len, Acc) ->
    Acc;
sum_unique_chars_helper(S, Len, Start, Acc) ->
    Sub = sub_string(S, Start + 1, Len - Start),
    sum_unique_chars_helper(S, Len, Start + 1, Acc + unique_chars(Sub)).

unique_chars(Sub) ->
    unique_chars_helper(Sub, []).

unique_chars_helper("", Acc) ->
    length(Acc);
unique_chars_helper([H | T], Acc) ->
    case lists:member(H, Acc) of
        true ->
            unique_chars_helper(T, Acc);
        false ->
            unique_chars_helper(T, [H | Acc])
    end.