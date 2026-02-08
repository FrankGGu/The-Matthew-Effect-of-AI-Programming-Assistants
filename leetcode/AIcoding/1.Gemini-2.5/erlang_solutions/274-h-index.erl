-module(solution).
-export([h_index/1]).

h_index(Citations) ->
    SortedCitations = lists:sort(Citations),
    N = length(SortedCitations),
    find_h(SortedCitations, N, 0).

find_h([], _N, _Index) ->
    0;
find_h([H|_T], N, Index) ->
    PotentialH = N - Index,
    if
        H >= PotentialH ->
            PotentialH;
        true ->
            find_h(_T, N, Index + 1)
    end.