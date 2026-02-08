-module(exam_room).
-export([new/1, seat/1, leave/2]).

new(N) ->
    Occupied = gb_sets:new(),
    InitialGap = calculate_gap_tuple(-1, N, N),
    Gaps = gb_sets:add(InitialGap, gb_sets:new()),
    #{ n => N, occupied => Occupied, gaps => Gaps }.

seat(State) ->
    N = maps:get(n, State),
    Occupied = maps:get(occupied, State),
    Gaps = maps:get(gaps, State),

    {ChosenSeat, OriginalS, OriginalE, NewGaps1} =
        case gb_sets:is_empty(Occupied) of
            true ->
                {0, -1, N, gb_sets:new()};
            false ->
                {NegDist, SeatIdx, S, E} = gb_sets:take_smallest(Gaps),
                {SeatIdx, S, E, gb_sets:del({NegDist, SeatIdx, S, E}, Gaps)}
        end,

    NewOccupied = gb_sets:add(ChosenSeat, Occupied),

    NewGaps2 = NewGaps1,
    NewGaps3 =
        if ChosenSeat > OriginalS ->
            GapS_Seat = calculate_gap_tuple(OriginalS, ChosenSeat, N),
            gb_sets:add(GapS_Seat, NewGaps2);
        true ->
            NewGaps2
        end,
    FinalGaps =
        if ChosenSeat < OriginalE ->
            GapSeat_E = calculate_gap_tuple(ChosenSeat, OriginalE, N),
            gb_sets:add(GapSeat_E, NewGaps3);
        true ->
            NewGaps3
        end,

    {#{ n => N, occupied => NewOccupied, gaps => FinalGaps }, ChosenSeat}.

leave(State, P) ->
    N = maps:get(n, State),
    Occupied = maps:get(occupied, State),
    Gaps = maps:get(gaps, State),

    NewOccupied = gb_sets:del(P, Occupied),
    {Prev, Next} = find_neighbors(P, NewOccupied, N),

    NewGaps1 = Gaps,
    NewGaps2 =
        if P > Prev + 1 ->
            GapPrev_P = calculate_gap_tuple(Prev, P, N),
            gb_sets:del(GapPrev_P, NewGaps1);
        true ->
            NewGaps1
        end,
    NewGaps3 =
        if P < Next - 1 ->
            GapP_Next = calculate_gap_tuple(P, Next, N),
            gb_sets:del(GapP_Next, NewGaps2);
        true ->
            NewGaps2
        end,

    MergedGap = calculate_gap_tuple(Prev, Next, N),
    FinalGaps = gb_sets:add(MergedGap, NewGaps3),

    #{ n => N, occupied => NewOccupied, gaps => FinalGaps }.

calculate_gap_tuple(S, E, N) ->
    Distance =
        case {S, E} of
            {-1, _} -> E;
            {_, N} -> N - 1 - S;
            {_, _} -> (E - S) div 2
        end,
    SeatIndex =
        case {S, E} of
            {-1, _} -> 0;
            {_, N} -> N - 1;
            {_, _} -> S + (E - S) div 2
        end,
    {-Distance, SeatIndex, S, E}.

find_neighbors(P, OccupiedSet, N) ->
    Prev = case gb_sets:prev(P, OccupiedSet) of
               none -> -1;
               {ok, Val} -> Val
           end,
    Next = case gb_sets:next(P, OccupiedSet) of
               none -> N;
               {ok, Val} -> Val
           end,
    {Prev, Next}.