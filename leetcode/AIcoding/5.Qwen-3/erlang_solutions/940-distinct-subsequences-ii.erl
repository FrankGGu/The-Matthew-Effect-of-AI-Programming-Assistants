-module(distinct_subsequences_ii).
-export([distinct_subseq/1]).

distinct_subseq(S) ->
    distinct_subseq(S, 0, 0, 1, dict:new()).

distinct_subseq([], _, _, Count, _) ->
    Count;
distinct_subseq([C | T], Index, Last, Count, D) ->
    NewCount = (Count * 2) rem 1000000007,
    Prev = dict:fetch(C, D, 0),
    NewCount2 = (NewCount - Prev + 1000000007) rem 1000000007,
    NewD = dict:store(C, Count, D),
    distinct_subseq(T, Index + 1, C, NewCount2, NewD).