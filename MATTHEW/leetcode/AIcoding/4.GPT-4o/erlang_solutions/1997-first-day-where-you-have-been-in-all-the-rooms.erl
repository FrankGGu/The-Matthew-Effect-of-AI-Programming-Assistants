-module(solution).
-export([first_day_where_you_have_been_in_all_rooms/2]).

first_day_where_you_have_been_in_all_rooms(D, A) ->
    Rooms = lists:map(fun(X) -> A * X div D end, lists:seq(0, D - 1)),
    lists:foldl(fun(X, Acc) -> case Acc of
        {ok, N} when X >= N -> {ok, N + 1};
        _ -> {error, N}
    end, {ok, 0}, Rooms).