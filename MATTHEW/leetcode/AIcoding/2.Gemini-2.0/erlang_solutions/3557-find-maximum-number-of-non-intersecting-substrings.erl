-module(find_max_non_intersecting_substrings).
-export([max_num_of_substrings/1]).

max_num_of_substrings(S) ->
    N = length(S),
    First = lists:map(fun(C) -> find_first(C, S) end, lists:seq($a, $z)),
    Last = lists:map(fun(C) -> find_last(C, S) end, lists:seq($a, $z)),
    Intervals = find_intervals(S, First, Last),
    lists:foldl(fun(Interval, Acc) ->
                        case is_intersecting(Interval, Acc) of
                            true ->
                                case is_smaller(Interval, lists:last(Acc)) of
                                    true ->
                                        lists:sublist(Acc, 1, length(Acc) - 1) ++ [Interval];
                                    false ->
                                        Acc
                                end;
                            false ->
                                Acc ++ [Interval]
                        end
                end, [], lists:sort(fun({A1, B1}, {A2, B2}) -> B1 < B2 end, Intervals)).

find_first(Char, S) ->
    find_first_helper(Char, S, 1).

find_first_helper(Char, S, Index) ->
    case lists:nth(Index, S) of
        Char ->
            Index;
        _ ->
            case Index == length(S) of
                true ->
                    infinity;
                false ->
                    find_first_helper(Char, S, Index + 1)
            end
    end.

find_last(Char, S) ->
    find_last_helper(Char, S, length(S)).

find_last_helper(Char, S, Index) ->
    case lists:nth(Index, S) of
        Char ->
            Index;
        _ ->
            case Index == 1 of
                true ->
                    -infinity;
                false ->
                    find_last_helper(Char, S, Index - 1)
            end
    end.

find_intervals(S, First, Last) ->
    find_intervals_helper(S, First, Last, lists:seq($a, $z), []).

find_intervals_helper(S, First, Last, [], Acc) ->
    lists:filter(fun(Interval) -> is_valid_interval(Interval, S, First, Last) end, Acc);
find_intervals_helper(S, First, Last, [Char | Rest], Acc) ->
    case lists:nth(Char - $a + 1, First) < lists:nth(Char - $a + 1, Last) of
        true ->
            find_intervals_helper(S, First, Last, Rest, Acc ++ [{lists:nth(Char - $a + 1, First), lists:nth(Char - $a + 1, Last)}]);
        false ->
            find_intervals_helper(S, First, Last, Rest, Acc)
    end.

is_valid_interval({Start, End}, S, First, Last) ->
    is_valid_interval_helper({Start, End}, S, lists:seq(Start, End), First, Last).

is_valid_interval_helper({Start, End}, S, [], First, Last) ->
    true;
is_valid_interval_helper({Start, End}, S, [Index | Rest], First, Last) ->
    Char = lists:nth(Index, S),
    FirstIndex = lists:nth(Char - $a + 1, First),
    LastIndex = lists:nth(Char - $a + 1, Last),
    case FirstIndex < Start orelse LastIndex > End of
        true ->
            false;
        false ->
            is_valid_interval_helper({Start, End}, S, Rest, First, Last)
    end.

is_intersecting({A1, B1}, Intervals) ->
    lists:any(fun({A2, B2}) ->
                    (A1 < A2 andalso B1 > A2) orelse
                    (A1 < B2 andalso B1 > B2) orelse
                    (A1 > A2 andalso B1 < B2) orelse
                    (A1 < A2 andalso B1 > B2)
                end, Intervals).

is_smaller({A1, B1}, {A2, B2}) ->
    A1 > A2 andalso B1 < B2.