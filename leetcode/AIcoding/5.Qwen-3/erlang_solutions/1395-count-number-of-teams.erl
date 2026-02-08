-module(solution).
-export([num_teams/1]).

num_teams(Rating) ->
    num_teams(Rating, 0, 0).

num_teams([], _, Acc) ->
    Acc;
num_teams([R | Rest], Index, Acc) ->
    Left = count_less(Rating, Index),
    Right = count_greater(Rating, Index),
    Acc2 = Acc + Left * Right,
    Left2 = count_greater(Rating, Index),
    Right2 = count_less(Rating, Index),
    num_teams(Rest, Index + 1, Acc2 + Left2 * Right2).

count_less([], _) ->
    0;
count_less([R | Rest], Index) ->
    if
        R < lists:nth(Index + 1, []) -> 0;
        true -> 
            case lists:member(R, lists:sublist(Rating, Index)) of
                true -> 1 + count_less(Rest, Index);
                false -> count_less(Rest, Index)
            end
    end.

count_greater([], _) ->
    0;
count_greater([R | Rest], Index) ->
    if
        R > lists:nth(Index + 1, []) -> 0;
        true -> 
            case lists:member(R, lists:sublist(Rating, Index)) of
                true -> 1 + count_greater(Rest, Index);
                false -> count_greater(Rest, Index)
            end
    end.