-module(solution).
-export([partition_string/2]).

-spec partition_string(S :: unicode:unicode_binary(), K :: integer()) -> integer().
partition_string(S_binary, K) ->
    S_list = unicode:characters_to_list(S_binary),
    partition_string_impl(S_list, K, 0, 0).

partition_string_impl([], _K, _CurrentValue, Count) ->
    Count + 1;
partition_string_impl([H|T], K, CurrentValue, Count) ->
    Digit = H - $0,
    ProposedNewValue = CurrentValue * 10 + Digit,
    if
        ProposedNewValue =< K ->
            partition_string_impl(T, K, ProposedNewValue, Count);
        true -> %% ProposedNewValue > K
            partition_string_impl(T, K, Digit, Count + 1)
    end.