-module(solution).
-export([latestTimeCatchTheBus/3]).

latestTimeCatchTheBus(Buses, Passengers, Capacity) ->
    SortedBuses = lists:sort(Buses),
    SortedPassengers = lists:sort(Passengers),

    InitialState = {SortedPassengers, sets:new(), {0, false, 0}},

    {_FinalRemainingPassengers, FinalTakenTimesSet, {LastBusDepartureTime, LastBusWasFull, LastPassengerOnLastBus}} =
        lists:foldl(
            fun(BusTime, {CurrentRemainingPassengers, AccTakenTimesSet, _LastBusInfo}) ->
                {NewRemainingPassengers, RemainingCapacity, BoardedThisBusList} =
                    fill_bus_optimized(BusTime, Capacity, CurrentRemainingPassengers, []),

                NewAccTakenTimesSet = lists:foldl(fun(PTime, Set) -> sets:add_element(PTime, Set) end, AccTakenTimesSet, BoardedThisBusList),

                ThisBusWasFull = (RemainingCapacity == 0),
                ThisBusLastPassengerTime = case BoardedThisBusList of
                                               [] -> 0;
                                               _ -> lists:last(BoardedThisBusList)
                                           end,

                {NewRemainingPassengers, NewAccTakenTimesSet, {BusTime, ThisBusWasFull, ThisBusLastPassengerTime}}
            end,
            InitialState,
            SortedBuses
        ),

    CandidateTime =
        case LastBusWasFull of
            true -> LastPassengerOnLastBus - 1;
            false -> LastBusDepartureTime
        end,

    find_latest_available_time(CandidateTime, FinalTakenTimesSet).

fill_bus_optimized(_BusTime, 0, RemainingPassengers, AccBoardedThisBus) ->
    {RemainingPassengers, 0, lists:reverse(AccBoardedThisBus)};
fill_bus_optimized(_BusTime, CurrentCapacity, [], AccBoardedThisBus) ->
    {[], CurrentCapacity, lists:reverse(AccBoardedThisBus)};
fill_bus_optimized(BusTime, CurrentCapacity, [PassengerTime | RestPassengers], AccBoardedThisBus) ->
    if PassengerTime =< BusTime ->
        fill_bus_optimized(BusTime, CurrentCapacity - 1, RestPassengers, [PassengerTime | AccBoardedThisBus]);
    true ->
        {[PassengerTime | RestPassengers], CurrentCapacity, lists:reverse(AccBoardedThisBus)}
    end.

find_latest_available_time(Time, TakenTimesSet) ->
    if Time < 0 -> 0;
       sets:is_element(Time, TakenTimesSet) ->
           find_latest_available_time(Time - 1, TakenTimesSet);
       true ->
           Time
    end.