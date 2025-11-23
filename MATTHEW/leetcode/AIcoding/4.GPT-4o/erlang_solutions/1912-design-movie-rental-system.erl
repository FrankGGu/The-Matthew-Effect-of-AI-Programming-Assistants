-module(MovieRentalSystem).
-export([new/0, rent/3, return/2, get/1]).

-record(movie, {id, stock}).

new() ->
    ets:new(movies, [set, public, named_table]),
    ets:new(rentals, [set, public, named_table]),
    ok.

rent(MovieId, CustomerId, Days) ->
    case ets:lookup(movies, MovieId) of
        [{MovieId, Stock}] when Stock > 0 ->
            ets:insert(movies, {MovieId, Stock - 1}),
            CurrentDate = calendar:local_time(),
            ets:insert(rentals, {CustomerId, MovieId, CurrentDate, Days}),
            ok;
        _ ->
            {error, no_stock}
    end.

return(MovieId, CustomerId) ->
    case ets:lookup(rentals, {CustomerId, MovieId}) of
        [{CustomerId, MovieId, RentDate, Days}] ->
            ets:delete(rentals, {CustomerId, MovieId}),
            case ets:lookup(movies, MovieId) of
                [{MovieId, Stock}] ->
                    ets:insert(movies, {MovieId, Stock + 1}),
                    ok;
                _ -> ok
            end;
        _ -> {error, not_rented}
    end.

get(CustomerId) ->
    ets:match(rentals, {CustomerId, '_', '_', '_'}).