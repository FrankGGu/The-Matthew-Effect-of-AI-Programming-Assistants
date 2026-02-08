-module(min_length_of_anagram_concatenation).
-export([minAnagramLength/1]).

minAnagramLength(S) ->
    N = length(S),
    lists:foldl(fun(I, Acc) ->
        case is_valid(S, I) of
            true -> I;
            false -> Acc
        end
    end, N, lists:seq(1, N)).

is_valid(S, K) ->
    N = length(S),
    if
        N rem K /= 0 -> false;
        true ->
            Counts = count_chars(S),
            Total = maps:size(Counts),
            Chunk = lists:sublist(S, K),
            ChunkCounts = count_chars(Chunk),
            lists:all(fun({Char, _}) -> maps:get(Char, ChunkCounts, 0) == maps:get(Char, Counts, 0) end, maps:to_list(Counts))
    end.

count_chars(S) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, S).