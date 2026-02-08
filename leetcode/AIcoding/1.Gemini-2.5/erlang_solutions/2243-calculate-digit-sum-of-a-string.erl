-module(solution).
-export([digit_sum/2]).

digit_sum(S, K) when length(S) =< K ->
    S;
digit_sum(S, K) ->
    Chunks = split_string_into_chunks(S, K),
    SumsList = [sum_digits_in_string(Chunk) || Chunk <- Chunks],
    NewS = lists:flatten([integer_to_list(Sum) || Sum <- SumsList]),
    digit_sum(NewS, K).

split_string_into_chunks(S, K) ->
    split_string_into_chunks(S, K, []).

split_string_into_chunks([], _K, Acc) ->
    lists:reverse(Acc);
split_string_into_chunks(S, K, Acc) ->
    {Chunk, Rest} = lists:split(K, S),
    split_string_into_chunks(Rest, K, [Chunk | Acc]).

sum_digits_in_string(S) ->
    lists:sum([C - $0 || C <- S]).