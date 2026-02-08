-module(solution).
-export([find_duplicates/1]).

-spec find_duplicates(Nums :: [integer()]) -> [integer()].
find_duplicates(Nums) ->
    find_duplicates_internal(Nums, #{}, []).

find_duplicates_internal([], _SeenMap, Duplicates) ->
    lists:reverse(Duplicates);
find_duplicates_internal([H|T], SeenMap, Duplicates) ->
    case maps:is_key(H, SeenMap) of
        true ->
            find_duplicates_internal(T, SeenMap, [H|Duplicates]);
        false ->
            find_duplicates_internal(T, maps:put(H, true, SeenMap), Duplicates)
    end.