-module(solution).
-export([minimumAbsoluteDifference/1]).

minimumAbsoluteDifference(Arr) ->
    SortedArr = lists:sort(Arr),
    MinDiff = find_min_diff(SortedArr),
    find_pairs(SortedArr, MinDiff).

find_min_diff([_]) ->
    0; %% Should not be reached given problem constraints (Arr has at least 2 elements)
find_min_diff([H1, H2 | T]) ->
    find_min_diff_loop([H2 | T], abs(H2 - H1)).

find_min_diff_loop([_], MinSoFar) ->
    MinSoFar;
find_min_diff_loop([H1, H2 | T], MinSoFar) ->
    NewDiff = abs(H2 - H1),
    find_min_diff_loop([H2 | T], min(MinSoFar, NewDiff)).

find_pairs([_], _MinDiff) ->
    [];
find_pairs([H1, H2 | T], MinDiff) ->
    CurrentPair = if
                      abs(H2 - H1) == MinDiff -> [[H1, H2]];
                      true -> []
                  end,
    CurrentPair ++ find_pairs([H2 | T], MinDiff).