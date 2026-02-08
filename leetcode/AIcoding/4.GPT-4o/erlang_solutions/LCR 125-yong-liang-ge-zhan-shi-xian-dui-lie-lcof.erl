-module(solution).
-export([min_operations/1]).

min_operations(Books) ->
    Count = length(Books),
    SortedBooks = lists:sort(Books),
    UniqueBooks = lists:usort(SortedBooks),
    UniqueCount = length(UniqueBooks),
    Count - UniqueCount.