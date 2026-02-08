-module(shortest_impossible_sequence).
-export([shortest_impossible_sequence/2]).

shortest_impossible_sequence(Rolls, K) ->
    shortest_impossible_sequence(Rolls, K, 1).

shortest_impossible_sequence(Rolls, K, Len) ->
    case find_sequence(Rolls, K, Len, []) of
        true ->
            Len;
        false ->
            shortest_impossible_sequence(Rolls, K, Len + 1)
    end.

find_sequence(Rolls, K, Len, Acc) ->
    lists:all(fun(Seq) ->
                      not is_subsequence(Seq, Rolls)
              end, sequences(K, Len)).

sequences(K, 1) ->
    [[I] || I <- lists:seq(1, K)];
sequences(K, Len) ->
    [Seq ++ [I] || Seq <- sequences(K, Len - 1), I <- lists:seq(1, K)].

is_subsequence(Seq, Rolls) ->
    is_subsequence(Seq, Rolls, 1, 1).

is_subsequence(Seq, Rolls, SeqIndex, RollsIndex) ->
    case {SeqIndex > length(Seq), RollsIndex > length(Rolls)} of
        {true, _} ->
            true;
        {_, true} ->
            false;
        {false, false} ->
            case lists:nth(SeqIndex, Seq) =:= lists:nth(RollsIndex, Rolls) of
                true ->
                    is_subsequence(Seq, Rolls, SeqIndex + 1, RollsIndex + 1);
                false ->
                    is_subsequence(Seq, Rolls, SeqIndex, RollsIndex + 1)
            end
    end.