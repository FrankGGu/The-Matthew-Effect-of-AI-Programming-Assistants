-module(solution).
-export([form_smallest_number/2]).

form_smallest_number(A, B) ->
    ListA = lists:sort(A),
    ListB = lists:sort(B),
    MinLen = min(length(ListA), length(ListB)),
    Lists = [ListA, ListB],
    Candidates = lists:foldl(fun(_, Acc) -> 
        lists:append(Acc, [lists:sublist(Lists, 1, MinLen)]) end, [], lists:seq(1, 2)),
    CandidatesSorted = lists:sort(Candidates),
    lists:flatten(lists:hd(CandidatesSorted)).