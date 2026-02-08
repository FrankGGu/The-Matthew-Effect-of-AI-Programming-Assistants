-spec max_num_of_substrings(S :: unicode:unicode_binary()) -> integer().
max_num_of_substrings(S) ->
    Str = unicode:characters_to_list(S),
    First = maps:new(),
    Last = maps:new(),
    {First1, Last1} = lists:foldl(fun(Char, {F, L}) ->
        case maps:is_key(Char, F) of
            true -> {F, maps:put(Char, L, L)};
            false -> {maps:put(Char, L, F), maps:put(Char, L, L)}
        end
    end, {First, Last}, Str),
    Intervals = maps:fold(fun(Char, Pos, Acc) ->
        Start = maps:get(Char, First1),
        End = maps:get(Char, Last1),
        [{Start, End} | Acc]
    end, [], First1),
    UniqueIntervals = lists:usort(Intervals),
    Merged = merge_intervals(UniqueIntervals),
    length(Merged).

merge_intervals(Intervals) ->
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A =< B end, Intervals),
    merge(Sorted, []).

merge([], Acc) -> lists:reverse(Acc);
merge([{S1, E1} | Rest], []) -> merge(Rest, [{S1, E1}]);
merge([{S1, E1} | Rest], [{S2, E2} | AccRest]) ->
    if
        S1 > E2 -> merge(Rest, [{S1, E1}, {S2, E2} | AccRest]);
        true -> merge(Rest, [{S2, max(E1, E2)} | AccRest])
    end.