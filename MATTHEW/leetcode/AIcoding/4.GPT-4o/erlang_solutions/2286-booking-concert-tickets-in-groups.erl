-module(solution).
-export([concert_tickets/2]).

concert_tickets(N, Groups) ->
    TotalSeats = lists:duplicate(N, true),
    lists:map(fun(Group) -> book_seats(TotalSeats, Group) end, Groups).

book_seats(Seats, GroupSize) ->
    case find_seats(Seats, GroupSize) of
        {ok, Seats} -> {ok, Seats};
        {error, _} -> {error, "Not enough seats"}
    end.

find_seats(Seats, GroupSize) ->
    SeatCount = length(Seats),
    lists:foldl(fun(Index, Acc) ->
        case Acc of
            {ok, _} -> Acc;
            {error, _} ->
                case can_book(Seats, Index, GroupSize) of
                    true -> {ok, book(Seats, Index, GroupSize)};
                    false -> Acc
                end
        end
    end, {error, "Not enough seats"}, lists:seq(0, SeatCount - 1)).

can_book(Seats, Start, GroupSize) ->
    lists:all(fun(X) -> lists:nth(X + 1, Seats) end, lists:seq(Start, Start + GroupSize - 1)).

book(Seats, Start, GroupSize) ->
    lists:map(fun(Index) -> false end, lists:seq(Start, Start + GroupSize - 1)).