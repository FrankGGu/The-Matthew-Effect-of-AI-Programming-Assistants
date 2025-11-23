-module(exam_room).
-export([exam_room/1, seat/1, leave/2]).

-record(state, {n, seats = []}).

exam_room(n) ->
    {ok, #state{n = n, seats = []}}.

seat(State) ->
    #state{n = N, seats = Seats} = State,
    case Seats of
        [] ->
            {0, #state{n = N, seats = [0]}};
        _ ->
            F = fun(Seats0) ->
                lists:foldl(
                  fun({A,B}, {MaxDist, MaxPos}) ->
                      Dist = (B - A) div 2,
                      if Dist > MaxDist then
                          {Dist, A + Dist}
                      else
                          {MaxDist, MaxPos}
                      end
                  end, {0, 0}, lists:zip(Seats, tl(Seats0)))
            end,
            {MaxDist, MaxPos} = F([0 | Seats]),
            if hd(Seats) > MaxDist then
                {hd(Seats) div 2, hd(Seats) div 2}
            else
               if (N - 1 - lists:last(Seats)) > MaxDist then
                   {N - 1, N - 1}
               else
                   {MaxPos, MaxPos}
               end
            end,
            {Pos, NewState} =
            case Seats of
                [] ->
                    {0, #state{n = N, seats = [0]}};
                _ ->
                    F = fun(Seats0) ->
                        lists:foldl(
                          fun({A,B}, {MaxDist, MaxPos}) ->
                              Dist = (B - A) div 2,
                              if Dist > MaxDist then
                                  {Dist, A + Dist}
                              else
                                  {MaxDist, MaxPos}
                              end
                          end, {0, 0}, lists:zip(Seats, tl(Seats)))
                    end,
                    {MaxDist, MaxPos} = F([0 | Seats]),
                    if hd(Seats) > MaxDist then
                        Pos1 = hd(Seats) div 2,
                        NewSeats = lists:sort([Pos1 | Seats]),
                        {Pos1, #state{n = N, seats = NewSeats}}
                    else
                        if (N - 1 - lists:last(Seats)) > MaxDist then
                            Pos2 = N - 1,
                            NewSeats = lists:sort([Pos2 | Seats]),
                            {Pos2, #state{n = N, seats = NewSeats}}
                        else
                            Pos3 = MaxPos,
                            NewSeats = lists:sort([Pos3 | Seats]),
                            {Pos3, #state{n = N, seats = NewSeats}}
                        end
                    end
            end,
            {Pos, NewState}.

leave(State, P) ->
    #state{n = N, seats = Seats} = State,
    NewSeats = lists:delete(P, Seats),
    {ok, #state{n = N, seats = NewSeats}}.