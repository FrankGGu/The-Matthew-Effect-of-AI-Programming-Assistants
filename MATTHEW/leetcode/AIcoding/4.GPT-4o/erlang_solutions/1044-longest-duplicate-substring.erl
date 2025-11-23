-module(solution).
-export([longestDupSubstring/1]).

longestDupSubstring(S) ->
    N = length(S),
    {Hash, Base} = hash_and_base(S, N),
    binary_to_list(longest_dup_substring(S, Hash, Base, N)).

hash_and_base(S, N) ->
    Base = 256,
    Hash = lists:foldl(fun(_, {H, P}) -> {((H * Base) rem (2 bsr 32)) + 1, (P * Base) rem (2 bsr 32)} end, {0, 1}, S),
    {Hash, Base}.

longest_dup_substring(S, Hash, Base, N) ->
    {L, R} = binary_to_list(lists:foldl(fun(_, {L, R}) -> {L + 1, R} end, {0, 0}, S)),
    longest_dup_substring(S, Hash, Base, L, R).

longest_dup_substring(S, Hash, Base, L, R) when L < R ->
    Mid = (L + R) div 2,
    case search(S, Mid, Hash, Base) of
        none -> longest_dup_substring(S, Hash, Base, L, Mid);
        {ok, Start} -> lists:sublist(S, Start, Mid) ++ longest_dup_substring(S, Hash, Base, Mid + 1, R)
    end.

search(S, L, Hash, Base) ->
    Seen = maps:new(),
    {Hash, Base, Length} = hash_substring(S, L, Hash, Base),
    search(S, L, Seen, Hash, Length).

hash_substring(S, L, Hash, Base) ->
    Hash1 = Hash,
    Length = length(S),
    lists:foldl(fun(I, {H, N}) ->
        if I + L > Length -> {H, N};
        true -> 
            NewHash = (H * Base - (binary_to_list(lists:nth(I + 1, S)) * (Base bsr L)) + binary_to_list(lists:nth(I + L, S))) rem (2 bsr 32),
            case maps:is_key(NewHash, N) of
                true -> {ok, I};
                false -> {NewHash, maps:put(NewHash, I, N)}
            end
        end
    end, {Hash1, maps:put(Hash1, 0, 0)}, lists:seq(0, length(S) - L)).

binary_to_list(Bin) ->
    lists:map(fun(X) -> <<X:8>> end, Bin).