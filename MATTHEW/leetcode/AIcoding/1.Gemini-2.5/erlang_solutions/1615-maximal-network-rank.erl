-module(solution).
-export([maximalNetworkRank/2]).

maximalNetworkRank(N, Roads) ->
    Degrees = maps:from_list([{I, 0} || I <- lists:seq(0, N - 1)]),
    ConnectedPairs = sets:new(),

    {FinalDegrees, FinalConnectedPairs} = lists:foldl(
        fun([U, V], {AccDegrees, AccConnectedPairs}) ->
            NewAccDegrees1 = maps:update_with(U, fun(Val) -> Val + 1 end, 1, AccDegrees),
            NewAccDegrees2 = maps:update_with(V, fun(Val) -> Val + 1 end, 1, NewAccDegrees1),

            Pair = {min(U, V), max(U, V)},
            NewAccConnectedPairs = sets:add_element(Pair, AccConnectedPairs),
            {NewAccDegrees2, NewAccConnectedPairs}
        end,
        {Degrees, ConnectedPairs},
        Roads
    ),

    MaxRank = lists:foldl(
        fun(I, CurrentMaxRank) ->
            lists:foldl(
                fun(J, InnerCurrentMaxRank) ->
                    DegreeI = maps:get(I, FinalDegrees),
                    DegreeJ = maps:get(J, FinalDegrees),

                    Rank = DegreeI + DegreeJ,

                    IsConnected = sets:is_element({min(I, J), max(I, J)}, FinalConnectedPairs),

                    ActualRank = if IsConnected -> Rank - 1;
                                    true -> Rank
                                 end,

                    max(InnerCurrentMaxRank, ActualRank)
                end,
                CurrentMaxRank,
                lists:seq(I + 1, N - 1)
            )
        end,
        0,
        lists:seq(0, N - 1)
    ),

    MaxRank.