-module(seat_reservation_manager).
-export([init/1, reserve/1, unreserve/2]).

init(N) ->
    {ok, gb_sets:from_list(lists:seq(1, N))}.

reserve(Pid) ->
    case gb_sets:is_empty(Pid) of
        true -> -1;
        false ->
            {Min, NewPid} = gb_sets:take_smallest(Pid),
            {Min, NewPid}
    end.

unreserve(Pid, Seat) ->
    gb_sets:add(Seat, Pid).