-module(movie_rental).
-export([start/0, rent_movie/3, drop_movie/3, report/0]).

start() ->
    ets:new(movies, [named_table, public, set]),
    ets:new(rented, [named_table, public, set]).

rent_movie(Shop, Movie, Price) ->
    ets:insert(movies, {Shop, Movie, Price}).

drop_movie(Shop, Movie) ->
    ets:delete(movies, {Shop, Movie, _}).

rent(Shop, Movie, Customer) ->
    case ets:lookup(movies, {Shop, Movie}) of
        [{Shop, Movie, Price}] ->
            ets:insert(rented, {Customer, Shop, Movie, Price}),
            true;
        [] ->
            false
    end.

drop(Shop, Movie, Customer) ->
    ets:delete(rented, {Customer, Shop, Movie, _}).

search(Movie) ->
    lists:sort([ {Price, Shop} || {Shop, Movie, Price} <- ets:tab2list(movies),
                                   lists:member(Movie, [element(2, X) || X <- ets:tab2list(movies), element(2, X) == Movie])]).

report() ->
    lists:sort([ {Price, Customer, Shop, Movie} || {Customer, Shop, Movie, Price} <- ets:tab2list(rented) ]).