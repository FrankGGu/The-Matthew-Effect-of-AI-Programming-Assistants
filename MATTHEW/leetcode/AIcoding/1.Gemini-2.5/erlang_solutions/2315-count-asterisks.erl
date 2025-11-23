-module(solution).
-export([count_asterisks/1]).

count_asterisks(S) ->
    count_asterisks_acc(S, 0, false).

count_asterisks_acc([], Count, _InPair) ->
    Count;
count_asterisks_acc([$| | T], Count, InPair) ->
    count_asterisks_acc(T, Count, not InPair);
count_asterisks_acc([$* | T], Count, false) ->
    count_asterisks_acc(T, Count + 1, false);
count_asterisks_acc([$* | T], Count, true) ->
    count_asterisks_acc(T, Count, true);
count_asterisks_acc([_C | T], Count, InPair) ->
    count_asterisks_acc(T, Count, InPair).