-module(solution).
-export([longestDiverseString/3]).

longestDiverseString(A, B, C) ->
    InitialCounts = [{A, $a}, {B, $b}, {C, $c}],
    longestDiverseString_loop(InitialCounts, []).

longestDiverseString_loop(Counts, Acc) ->
    SortedCounts = lists:sort(fun({C1, _}, {C2, _}) -> C1 >= C2 end, Counts),

    case SortedCounts of
        [] ->
            lists:reverse(Acc);
        [{Count1, Char1} | Rest] ->
            CanAppend1 = can_append(Acc, Char1),

            if Count1 > 0 and CanAppend1 ->
                NewCounts = update_counts(Counts, Char1, -1),
                longestDiverseString_loop(NewCounts, [Char1 | Acc]);
            true ->
                case Rest of
                    [{Count2, Char2} | _] when Count2 > 0 ->
                        NewCounts = update_counts(Counts, Char2, -1),
                        longestDiverseString_loop(NewCounts, [Char2 | Acc]);
                    _ ->
                        lists:reverse(Acc)
                end
            end
    end.

can_append(Acc, Char) ->
    case Acc of
        [C1, C2 | _] when C1 == Char and C2 == Char ->
            false;
        _ ->
            true
    end.

update_counts(Counts, Char, Delta) ->
    lists:map(fun({Count, C}) ->
        if C == Char -> {Count + Delta, C};
        true -> {Count, C}
        end
    end, Counts).