-module(solution).
-export([max_groups/1]).

max_groups(Hand) ->
    SortedHand = lists:sort(Hand),
    count_groups(SortedHand, 0).

count_groups([], Count) -> Count;
count_groups([H | T], Count) ->
    case T of
        [H | Rest] ->
            case Rest of
                [H | _] -> count_groups(Rest, Count + 1);
                _ -> count_groups(Rest, Count + 1)
            end;
        _ -> count_groups(T, Count)
    end.