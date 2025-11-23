-module(exam_room).
-export([new/0, seat/0, leave/1]).

-record(state, {n, seats = [], occupied = sets:new()}).

new() ->
    #state{}.

seat() ->
    State = erlang:get(?MODULE),
    case State#state.seats of
        [] ->
            erlang:put(?MODULE, State#state{seats = [0], occupied = sets:add_element(0, State#state.occupied)}),
            0;
        _ ->
            Best = find_best(State),
            erlang:put(?MODULE, State#state{seats = lists:sort([Best | State#state.seats]), occupied = sets:add_element(Best, State#state.occupied)}),
            Best
    end.

leave(P) ->
    State = erlang:get(?MODULE),
    erlang:put(?MODULE, State#state{seats = lists:delete(P, State#state.seats), occupied = sets:del_element(P, State#state.occupied)}).

find_best(State) ->
    N = State#state.n,
    Seats = State#state.seats,
    case Seats of
        [] -> 0;
        _ ->
            MaxDist = -1,
            BestPos = 0,
            lists:foldl(fun(Pos, Acc) ->
                                {MaxDist, BestPos} = Acc,
                                Prev = prev_pos(Seats, Pos),
                                Next = next_pos(Seats, Pos),
                                Dist = if
                                           Prev == -1 -> Pos;
                                           Next == -1 -> N - 1 - Pos;
                                           true -> min(Pos - Prev, Next - Pos)
                                       end,
                                if
                                    Dist > MaxDist -> {Dist, Pos};
                                    true -> Acc
                                end
                            end, {MaxDist, BestPos}, Seats)
    end.

prev_pos(Seats, Pos) ->
    lists:foldl(fun(S, Acc) ->
                        if S < Pos andalso Acc == -1 -> S;
                           S < Pos -> S;
                           true -> Acc
                        end
                    end, -1, Seats).

next_pos(Seats, Pos) ->
    lists:foldl(fun(S, Acc) ->
                        if S > Pos andalso Acc == -1 -> S;
                           S > Pos -> S;
                           true -> Acc
                        end
                    end, -1, Seats).