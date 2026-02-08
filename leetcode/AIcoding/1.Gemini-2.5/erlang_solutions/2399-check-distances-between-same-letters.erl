-module(solution).
-export([check_distances/2]).

-spec check_distances(S :: unicode:unicode_binary() | unicode:unicode_list(), Distance :: [integer()]) -> boolean().
check_distances(S, Distance) ->
    check_distances_loop(S, Distance, 0, #{}).

check_distances_loop([], _Distance, _Idx, _FirstOccurrences) ->
    true;
check_distances_loop([Char | Rest], Distance, Idx, FirstOccurrences) ->
    AlphaIdx = Char - $a,
    ExpectedDistance = lists:nth(AlphaIdx + 1, Distance),

    case maps:is_key(Char, FirstOccurrences) of
        true ->
            FirstIdx = maps:get(Char, FirstOccurrences),
            ActualDistance = Idx - FirstIdx - 1,
            if ActualDistance == ExpectedDistance ->
                   check_distances_loop(Rest, Distance, Idx + 1, FirstOccurrences);
               true ->
                   false
            end;
        false ->
            NewFirstOccurrences = maps:put(Char, Idx, FirstOccurrences),
            check_distances_loop(Rest, Distance, Idx + 1, NewFirstOccurrences)
    end.