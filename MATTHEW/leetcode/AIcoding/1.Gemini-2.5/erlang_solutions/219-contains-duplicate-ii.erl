-module(solution).
-export([contains_nearby_duplicate/2]).

-spec contains_nearby_duplicate(Nums :: [integer()], K :: integer()) -> boolean().
contains_nearby_duplicate(Nums, K) ->
    contains_nearby_duplicate_impl(Nums, K, 0, #{}).

contains_nearby_duplicate_impl([], _K, _Index, _Map) ->
    false;
contains_nearby_duplicate_impl([H | T], K, Index, Map) ->
    case maps:find(H, Map) of
        {ok, LastSeenIndex} ->
            if
                Index - LastSeenIndex =< K ->
                    true;
                true ->
                    contains_nearby_duplicate_impl(T, K, Index + 1, maps:put(H, Index, Map))
            end;
        error ->
            contains_nearby_duplicate_impl(T, K, Index + 1, maps:put(H, Index, Map))
    end.