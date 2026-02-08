-module(seat_reservation_manager).
-export([new/1, reserve/1, cancel/1]).

-record(state, {reserved = dict:new(), next = 1, total}).

new(Total) ->
    {ok, spawn(fun() -> loop(#state{total = Total}) end)}.

reserve(Pid) ->
    Pid ! reserve.

cancel(Pid) ->
    Pid ! cancel.

loop(State) ->
    receive
        reserve ->
            case reserve_seat(State#state.reserved, State#state.total, State#state.next) of
                {ok, Seat, NewReserved} ->
                    NewState = State#state{reserved = NewReserved, next = Seat + 1},
                    Pid ! Seat,
                    loop(NewState);
                error -> 
                    Pid ! error,
                    loop(State)
            end;
        cancel ->
            %% Handle cancel here if needed
            loop(State)
    end.

reserve_seat(Reserved, Total, Next) when Next > Total ->
    {error};
reserve_seat(Reserved, Total, Next) ->
    case dict:find(Next, Reserved) of
        {ok, _} -> 
            reserve_seat(Reserved, Total, Next + 1);
        error ->
            {ok, Next, dict:store(Next, true, Reserved)}
    end.