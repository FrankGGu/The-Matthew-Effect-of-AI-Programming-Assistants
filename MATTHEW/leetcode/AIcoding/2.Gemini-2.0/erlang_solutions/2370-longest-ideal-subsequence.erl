-module(longest_ideal_subsequence).
-export([longest_ideal_string/2]).

longest_ideal_string(S, K) ->
    longest_ideal_string(S, K, []).

longest_ideal_string([], _K, Acc) ->
    length(Acc);
longest_ideal_string([H|T], K, Acc) ->
    case is_ideal(H, Acc, K) of
        true ->
            longest_ideal_string(T, K, insert_sorted(H, Acc));
        false ->
            longest_ideal_string(T, K, Acc)
    end.

is_ideal(_H, [], _K) ->
    true;
is_ideal(H, [A|_], K) ->
    abs(H - A) =< K.

insert_sorted(H, []) ->
    [H];
insert_sorted(H, [A|T]) ->
    case H < A of
        true ->
            [H, A|T];
        false ->
            [A|insert_sorted(H, T)]
    end.