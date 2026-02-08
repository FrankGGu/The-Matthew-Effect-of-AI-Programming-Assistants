-module(solution).
-export([remove_duplicates/1]).

-spec remove_duplicates(Nums :: [integer()]) -> integer().
remove_duplicates(Nums) ->
    remove_duplicates_count(Nums, 0, undefined).

remove_duplicates_count([], Count, _LastUnique) ->
    Count;
remove_duplicates_count([H|T], Count, LastUnique) when H =:= LastUnique ->
    remove_duplicates_count(T, Count, LastUnique);
remove_duplicates_count([H|T], Count, _LastUnique) ->
    remove_duplicates_count(T, Count + 1, H).