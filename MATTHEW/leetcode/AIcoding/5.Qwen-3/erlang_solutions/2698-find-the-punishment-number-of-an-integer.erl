-module(punishment_number).
-export([punishment_number/1]).

punishment_number(N) ->
    punishment_number(N, 1, 0).

punishment_number(N, I, Acc) when I > N ->
    Acc;
punishment_number(N, I, Acc) ->
    case is_valid(I) of
        true -> punishment_number(N, I + 1, Acc + I * I);
        false -> punishment_number(N, I + 1, Acc)
    end.

is_valid(N) ->
    is_valid(integer_to_list(N), []).

is_valid([], _) ->
    true;
is_valid(S, Acc) ->
    lists:member(S, generate_substrings(S)).

generate_substrings(S) ->
    generate_substrings(S, 1, []).

generate_substrings(S, K, Acc) when K > length(S) ->
    Acc;
generate_substrings(S, K, Acc) ->
    Sub = lists:sublist(S, K),
    generate_substrings(S, K + 1, [Sub | Acc]).

is_valid(S, Acc) ->
    case lists:member(S, Acc) of
        true -> true;
        false -> is_valid(lists:tl(S), [S | Acc])
    end.