-module(movie_rental_system).
-export([new/0, search_movies/2, rent_movie/3, return_movie/3, get_rentals/1]).

new() ->
    {[], [], []}.

search_movies(Rentals, Query) ->
    Movies = lists:sort([{Id, Title} || {Id, Title, _} <- Rentals]),
    [Id || {Id, Title, _} <- Movies, string:find(Title, Query) /= nomatch].

rent_movie(Rentals, MovieId, UserId) ->
    case lists:keymember(MovieId, 1, Rentals) of
        true ->
            case lists:keymember(UserId, 2, Rentals) of
                true -> Rentals;
                false -> [{MovieId, UserId, 0} | Rentals]
            end;
        false -> Rentals
    end.

return_movie(Rentals, MovieId, UserId) ->
    case lists:keyfind(MovieId, 1, Rentals) of
        {MovieId, UserId, _} ->
            lists:keyreplace(MovieId, 1, Rentals, {MovieId, UserId, 1});
        _ -> Rentals
    end.

get_rentals(Rentals) ->
    [ {Id, UserId} || {Id, UserId, Status} <- Rentals, Status == 0 ].