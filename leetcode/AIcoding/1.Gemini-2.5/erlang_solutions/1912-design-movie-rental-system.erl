-module(movie_rental_system).

-export([new/3, search/2, rent/3, drop/3, report/1]).

-record(state, {
    all_movies_prices,          % gb_trees:tree({ShopID, MovieID}, Price)
    available_movies_by_id,     % gb_trees:tree(MovieID, gb_trees:tree({Price, ShopID}, true))
    rented_movies_by_sort_key   % gb_trees:tree({Price, ShopID, MovieID}, true)
}).

new(_N, _M, Prices) ->
    AllMoviesPrices = gb_trees:empty(),
    AvailableMoviesByID = gb_trees:empty(),

    {FinalAllMoviesPrices, FinalAvailableMoviesByID} =
        lists:foldl(
            fun([ShopID, MovieID, Price], {AccAllPrices, AccAvailableByID}) ->
                NewAccAllPrices = gb_trees:insert({ShopID, MovieID}, Price, AccAllPrices),

                InnerTree = gb_trees:get(MovieID, AccAvailableByID, gb_trees:empty()),
                NewInnerTree = gb_trees:insert({Price, ShopID}, true, InnerTree),
                NewAccAvailableByID = gb_trees:insert(MovieID, NewInnerTree, AccAvailableByID),

                {NewAccAllPrices, NewAccAvailableByID}
            end,
            {AllMoviesPrices, AvailableMoviesByID},
            Prices
        ),

    #state{
        all_movies_prices = FinalAllMoviesPrices,
        available_movies_by_id = FinalAvailableMoviesByID,
        rented_movies_by_sort_key = gb_trees:empty()
    }.

search(State, MovieID) ->
    AvailableMoviesByID = State#state.available_movies_by_id,

    case gb_trees:lookup(MovieID, AvailableMoviesByID) of
        {value, InnerTree} ->
            search_loop(gb_trees:iterator(InnerTree), MovieID, [], 5);
        _ ->
            []
    end.

search_loop(Iterator, MovieID, Acc, 0) ->
    lists:reverse(Acc);
search_loop(Iterator, MovieID, Acc, Limit) ->
    case gb_trees:next(Iterator) of
        {{_Price, ShopID}, _, NextIterator} ->
            search_loop(NextIterator, MovieID, [[ShopID, MovieID] | Acc], Limit - 1);
        none ->
            lists:reverse(Acc)
    end.

rent(State, ShopID, MovieID) ->
    AllMoviesPrices = State#state.all_movies_prices,
    AvailableMoviesByID = State#state.available_movies_by_id,
    RentedMoviesBySortKey = State#state.rented_movies_by_sort_key,

    Price = gb_trees:get({ShopID, MovieID}, AllMoviesPrices),

    case gb_trees:lookup(MovieID, AvailableMoviesByID) of
        {value, InnerTree} ->
            case gb_trees:is_defined({Price, ShopID}, InnerTree) of
                true ->
                    NewInnerTree = gb_trees:delete({Price, ShopID}, InnerTree),
                    NewAvailableMoviesByID = gb_trees:insert(MovieID, NewInnerTree, AvailableMoviesByID),

                    NewRentedMoviesBySortKey = gb_trees:insert({Price, ShopID, MovieID}, true, RentedMoviesBySortKey),

                    State#state{
                        available_movies_by_id = NewAvailableMoviesByID,
                        rented_movies_by_sort_key = NewRentedMoviesBySortKey
                    };
                false ->
                    State
            end;
        _ ->
            State
    end.

drop(State, ShopID, MovieID) ->
    AllMoviesPrices = State#state.all_movies_prices,
    AvailableMoviesByID = State#state.available_movies_by_id,
    RentedMoviesBySortKey = State#state.rented_movies_by_sort_key,

    Price = gb_trees:get({ShopID, MovieID}, AllMoviesPrices),

    case gb_trees:is_defined({Price, ShopID, MovieID}, RentedMoviesBySortKey) of
        true ->
            NewRentedMoviesBySortKey = gb_trees:delete({Price, ShopID, MovieID}, RentedMoviesBySortKey),

            InnerTree = gb_trees:get(MovieID, AvailableMoviesByID, gb_trees:empty()),
            NewInnerTree = gb_trees:insert({Price, ShopID}, true, InnerTree),
            NewAvailableMoviesByID = gb_trees:insert(MovieID, NewInnerTree, AvailableMoviesByID),

            State#state{
                available_movies_by_id = NewAvailableMoviesByID,
                rented_movies_by_sort_key = NewRentedMoviesBySortKey
            };
        false ->
            State
    end.

report(State) ->
    RentedMoviesBySortKey = State#state.rented_movies_by_sort_key,
    report_loop(gb_trees:iterator(RentedMoviesBySortKey), [], 5).

report_loop(Iterator, Acc, 0) ->
    lists:reverse(Acc);
report_loop(Iterator, Acc, Limit) ->
    case gb_trees:next(Iterator) of
        {{{_Price, ShopID, MovieID}}, _, NextIterator} ->
            report_loop(NextIterator, [[ShopID, MovieID] | Acc], Limit - 1);
        none ->
            lists:reverse(Acc)
    end.