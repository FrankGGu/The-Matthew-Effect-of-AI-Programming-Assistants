-module(solution).
-export([max_taxi_earnings/2]).

max_taxi_earnings(N, Rides) ->
    RidesByEnd0 = array:new(N + 1, {default, []}),
    RidesByEnd = lists:foldl(
        fun([Start, End, Tip], AccRidesByEnd) ->
            Earnings = End - Start + Tip,
            CurrentRides = array:get(End, AccRidesByEnd),
            array:set(End, [{Start, Earnings} | CurrentRides], AccRidesByEnd)
        end,
        RidesByEnd0,
        Rides
    ),

    Dp0 = array:new(N + 1, {default, 0}),

    DpFinal = lists:foldl(
        fun(I, CurrentDp) ->
            PrevMaxEarnings = array:get(I - 1, CurrentDp),
            MaxEarningsAtI = PrevMaxEarnings,

            RidesEndingAtI = array:get(I, RidesByEnd),
            NewMaxEarningsAtI = lists:foldl(
                fun({Start, Earnings}, AccMax) ->
                    max(AccMax, array:get(Start, CurrentDp) + Earnings)
                end,
                MaxEarningsAtI,
                RidesEndingAtI
            ),

            array:set(I, NewMaxEarningsAtI, CurrentDp)
        end,
        Dp0,
        lists:seq(1, N)
    ),

    array:get(N, DpFinal)
.