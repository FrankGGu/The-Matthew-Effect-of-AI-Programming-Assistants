-module(solution).
-export([maxNumberOfFamilies/2]).

maxNumberOfFamilies(N, ReservedSeats) ->
    RowMap = build_row_map(ReservedSeats, #{}).

    FamiliesFromReservedRows = maps:fold(
        fun(_Row, ReservedCols, Acc) ->
            Acc + families_in_row(ReservedCols)
        end,
        0,
        RowMap
    ),

    RowsWithReservations = maps:size(RowMap),
    FamiliesFromEmptyRows = (N - RowsWithReservations) * 2,

    FamiliesFromReservedRows + FamiliesFromEmptyRows.

build_row_map([], Acc) -> Acc;
build_row_map([[R, C] | T], Acc) ->
    UpdatedCols = case maps:find(R, Acc) of
                      {ok, ColsSet} -> gb_sets:add(C, ColsSet);
                      error -> gb_sets:from_list([C])
                  end,
    build_row_map(T, maps:put(R, UpdatedCols, Acc)).

families_in_row(ReservedCols) ->
    GroupA = [2,3,4,5],
    GroupB = [4,5,6,7],
    GroupC = [6,7,8,9],

    IsFreeA = is_group_free(GroupA, ReservedCols),
    IsFreeC = is_group_free(GroupC, ReservedCols),

    if IsFreeA and IsFreeC -> 2;
    IsFreeA or IsFreeC or is_group_free(GroupB, ReservedCols) -> 1;
    true -> 0
    end.

is_group_free(GroupSeats, ReservedCols) ->
    lists:all(fun(Seat) -> not gb_sets:is_member(Seat, ReservedCols) end, GroupSeats).