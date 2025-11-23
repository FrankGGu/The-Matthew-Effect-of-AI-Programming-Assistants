-module(solution).
-export([max_num_of_substrings/1]).

max_num_of_substrings(S) ->
    First = maps:new(),
    Last = maps:new(),
    {First1, Last1} = lists:foldl(fun(Char, {F, L}) ->
        case maps:is_key(Char, F) of
            true -> {F, maps:put(Char, CharIdx, L)};
            false -> {maps:put(Char, CharIdx, F), maps:put(Char, CharIdx, L)}
        end
    end, {First, Last}, lists:zip(lists:seq(1, length(S)), S)),
    Intervals = maps:fold(fun(Char, F, Acc) ->
        L = maps:get(Char, Last1),
        {Start, End} = expand_interval(F, L, First1, Last1),
        [{Start, End} | Acc]
    end, [], First1),
    Sorted = lists:sort(fun({A, B}, {C, D}) ->
        if
            B =:= D -> A > C;
            true -> B < D
        end
    end, Intervals),
    select_intervals(Sorted, -1, 0).

expand_interval(Start, End, First, Last) ->
    {NewStart, NewEnd} = expand(Start, End, First, Last),
    if
        NewStart =:= Start andalso NewEnd =:= End -> {Start, End};
        true -> expand_interval(NewStart, NewEnd, First, Last)
    end.

expand(Start, End, First, Last) ->
    lists:foldl(fun(Char, {S, E}) ->
        F = maps:get(Char, First),
        L = maps:get(Char, Last),
        {min(S, F), max(E, L)}
    end, {Start, End}, unique_chars(Start, End)).

unique_chars(Start, End) ->
    lists:usort(lists:sublist(S, Start, End - Start + 1)).

select_intervals([], _, Count) -> Count;
select_intervals([{S, E} | Rest], LastEnd, Count) when S > LastEnd ->
    select_intervals(Rest, E, Count + 1);
select_intervals([_ | Rest], LastEnd, Count) ->
    select_intervals(Rest, LastEnd, Count).