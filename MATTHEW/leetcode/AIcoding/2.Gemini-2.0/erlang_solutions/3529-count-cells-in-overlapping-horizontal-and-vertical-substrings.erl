-module(count_cells).
-export([number_of_common_cells/4]).

number_of_common_cells(N, M, HRanges, VRanges) ->
    HV = horizontal_overlap(N, HRanges),
    VV = vertical_overlap(M, VRanges),
    HV * VV.

horizontal_overlap(N, Ranges) ->
    overlap(N, Ranges).

vertical_overlap(M, Ranges) ->
    overlap(M, Ranges).

overlap(Size, []) ->
    Size;
overlap(Size, [Range|Rest]) ->
    overlap(Size, overlap(Range), Rest).

overlap(Size, {A1, A2}) ->
    overlap(Size, fun(B1, B2) ->
                         max(0, min(A2, B2) - max(A1, B1) + 1)
                 end).

overlap(Size, F, []) ->
    Size;
overlap(Size, F, [Range|Rest]) ->
    overlap(Size, F, overlap(Size, F, Range), Rest).

overlap(Size, F, X, []) ->
    X;
overlap(Size, F, X, [Range|Rest]) ->
    overlap(Size, F, F(X, overlap(Size, F, Range)), Rest).

overlap(Size, F, X, Y) ->
    F(X, Y).