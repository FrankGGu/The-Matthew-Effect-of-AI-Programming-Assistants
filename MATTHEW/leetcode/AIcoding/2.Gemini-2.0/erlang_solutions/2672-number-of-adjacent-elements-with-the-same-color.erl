-module(adjacent_elements).
-export([get_adjacent_elements_with_same_color/2]).

get_adjacent_elements_with_same_color(N, Queries) ->
    Colors = lists:duplicate(N, 0),
    fold_queries(Queries, Colors, 0).

fold_queries([], _, Count) ->
    Count;
fold_queries([{Index, Color} | Rest], Colors, Count) ->
    NewColors = lists:replace(Index + 1, Color, Colors),
    NewCount = update_count(NewColors, Colors, Index, Count),
    fold_queries(Rest, NewColors, NewCount).

update_count(NewColors, OldColors, Index, Count) ->
    OldAdjacentCount = count_adjacent(OldColors, Index),
    NewAdjacentCount = count_adjacent(NewColors, Index),
    Count + NewAdjacentCount - OldAdjacentCount.

count_adjacent(Colors, Index) ->
    Count1 = case Index > 0 andalso lists:nth(Index, Colors) =:= lists:nth(Index + 1, Colors) of
        true -> 1;
        false -> 0
    end,
    Count2 = case Index < length(Colors) - 1 andalso lists:nth(Index + 2, Colors) =:= lists:nth(Index + 1, Colors) of
        true -> 1;
        false -> 0
    end,
    Count1 + Count2.