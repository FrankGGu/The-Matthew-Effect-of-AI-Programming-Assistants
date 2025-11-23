-module(movie_rental_system).
-export([init/1, search/2, rent/3, drop/3, report/1]).

-record(movie, {shop, movie, price}).

init(_Movies) ->
    {ok, {gb_trees:empty(), gb_trees:empty(), sets:new()}}.

search({MoviesByMovie, _MoviesByShopPrice, _Rented}, movie) ->
    case gb_trees:lookup(movie, MoviesByMovie) of
        {value, Shops} -> lists:sort([Shop || {Shop, _} <- Shops]);
        none -> []
    end.

rent({MoviesByMovie, MoviesByShopPrice, Rented}, shop, movie) ->
    case gb_trees:lookup(movie, MoviesByMovie) of
        {value, Shops} ->
            case lists:keyfind(shop, 1, Shops) of
                {Shop, Price} ->
                    NewMoviesByMovie = gb_trees:update(movie, lists:keydelete(shop, 1, Shops), MoviesByMovie),
                    NewMoviesByShopPrice = gb_trees:delete({Price, Shop, movie}, MoviesByShopPrice),
                    NewRented = sets:add_element({Shop, movie}, Rented),
                    {ok, {NewMoviesByMovie, NewMoviesByShopPrice, NewRented}};
                false ->
                    error
            end;
        none ->
            error
    end.

drop({MoviesByMovie, MoviesByShopPrice, Rented}, shop, movie) ->
    case sets:is_element({shop, movie}, Rented) of
        true ->
            {value, Shops} = gb_trees:lookup(movie, MoviesByMovie),
            Price = proplists:get_value(shop, Shops),
            NewMoviesByMovie = gb_trees:update(movie, [{shop, Price} | Shops], MoviesByMovie),
            NewMoviesByShopPrice = gb_trees:insert({Price, shop, movie}, MoviesByShopPrice),
            NewRented = sets:del_element({shop, movie}, Rented),
            {ok, {NewMoviesByMovie, NewMoviesByShopPrice, NewRented}};
        false ->
            error
    end.

report({_MoviesByMovie, MoviesByShopPrice, _Rented}) ->
    lists:sublist([{Shop, Movie} || {_Price, Shop, Movie} <- gb_trees:values(MoviesByShopPrice)], 5).