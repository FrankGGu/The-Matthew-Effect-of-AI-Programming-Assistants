-module(balanced_string).
-export([balanced_string/1]).

balanced_string(S) ->
    N = length(S),
    Counts = get_counts(S),
    K = N div 4,
    Need = get_need(Counts, K),
    if Need == #{q => 0, w => 0, e => 0, r => 0} ->
        0
    else
        find_min_length(S, Need, K)
    end.

get_counts(S) ->
    get_counts(S, #{q => 0, w => 0, e => 0, r => 0}).

get_counts([], Counts) ->
    Counts;
get_counts([H|T], Counts) ->
    NewCounts = case H of
        $Q -> Counts#{q => Counts#q + 1};
        $W -> Counts#{w => Counts#w + 1};
        $E -> Counts#{e => Counts#e + 1};
        $R -> Counts#{r => Counts#r + 1}
    end,
    get_counts(T, NewCounts).

get_need(Counts, K) ->
    #{
        q => max(0, Counts#q - K),
        w => max(0, Counts#w - K),
        e => max(0, Counts#e - K),
        r => max(0, Counts#r - K)
    }.

find_min_length(S, Need, K) ->
    find_min_length(S, Need, K, 0, 0, length(S)).

find_min_length(S, Need, K, L, R, MinLen) when R > length(S) ->
    MinLen;
find_min_length(S, Need, K, L, R, MinLen) ->
    Sub = lists:sublist(S, L + 1, R - L),
    SubCounts = get_counts(Sub),
    if check_need(Need, SubCounts) ->
        find_min_length(S, Need, K, L + 1, R, min(MinLen, R - L))
    else
        find_min_length(S, Need, K, L, R + 1, MinLen)
    end.

check_need(Need, SubCounts) ->
    (SubCounts#q >= Need#q) and (SubCounts#w >= Need#w) and (SubCounts#e >= Need#e) and (SubCounts#r >= Need#r).