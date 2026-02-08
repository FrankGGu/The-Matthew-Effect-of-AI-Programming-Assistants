-module(solution).
-export([count_almost_equal_pairs/1]).

count_almost_equal_pairs(Numbers) ->
    count_almost_equal_pairs(Numbers, 0, maps:new()).

count_almost_equal_pairs([], Count, _) ->
    Count;
count_almost_equal_pairs([N | Rest], Count, Map) ->
    Key = integer_to_list(N),
    case maps:find(Key, Map) of
        {ok, C} ->
            count_almost_equal_pairs(Rest, Count + C, maps:update(Key, C + 1, Map));
        error ->
            count_almost_equal_pairs(Rest, Count, maps:put(Key, 1, Map))
    end.