-module(minimum_moves).
-export([min_moves_to_capture_queen/8]).

min_moves_to_capture_queen(Ra, Ca, Rb, Cb, Rr, Cr, _Rq, _Cq) ->
    D1 = dist(Ra, Ca, Rb, Cb, Rr, Cr, 1);
    D2 = dist(Ra, Ca, Rb, Cb, Rr, Cr, 2);
    min(D1, D2).

dist(Ra, Ca, Rb, Cb, Rr, Cr, Type) ->
    case Type of
        1 ->
            if
                Ra == Rr,
                blocked_row(Ra, Ca, Cr, Rb, Cb)
            ->
                1000;
                Ra == Rr,
                not blocked_row(Ra, Ca, Cr, Rb, Cb)
            ->
                1;
                Ca == Cr,
                blocked_col(Ca, Ra, Rr, Rb, Cb)
            ->
                1000;
                Ca == Cr,
                not blocked_col(Ca, Ra, Rr, Rb, Cb)
            ->
                1;
                true ->
                    if
                        Ca == Cb, Ra == Rb ->
                            1;
                        true ->
                            1000
                    end
            end;
        2 ->
            if
                abs(Ra - Rr) == abs(Ca - Cr),
                blocked_diag(Ra, Ca, Rr, Cr, Rb, Cb)
            ->
                1000;
                abs(Ra - Rr) == abs(Ca - Cr),
                not blocked_diag(Ra, Ca, Rr, Cr, Rb, Cb)
            ->
                1;
                true ->
                    if
                        abs(Ra - Rb) == abs(Ca - Cb) ->
                            1;
                        true ->
                            1000
                    end
            end
    end.

blocked_row(Row, A, C, Bx, By) ->
    (A < C andalso C < Bx andalso Row == Row andalso Row == Row) orelse
    (A > C andalso C > Bx andalso Row == Row andalso Row == Row).

blocked_col(Col, A, C, Bx, By) ->
    (A < C andalso C < Bx andalso Col == Col andalso Col == Col) orelse
    (A > C andalso C > Bx andalso Col == Col andalso Col == Col).

blocked_diag(Ar, Ac, Cr, Cc, Br, Bc) ->
    (Ar < Cr andalso Ac < Cc andalso Cr < Br andalso Cc < Bc andalso (Cr - Ar) == (Cc - Ac) andalso (Br - Ar) == (Bc - Ac)) orelse
    (Ar < Cr andalso Ac > Cc andalso Cr < Br andalso Cc > Bc andalso (Cr - Ar) == (Ac - Cc) andalso (Br - Ar) == (Ac - Bc)) orelse
    (Ar > Cr andalso Ac < Cc andalso Cr > Br andalso Cc < Bc andalso (Ar - Cr) == (Cc - Ac) andalso (Ar - Br) == (Bc - Ac)) orelse
    (Ar > Cr andalso Ac > Cc andalso Cr > Br andalso Cc > Bc andalso (Ar - Cr) == (Ac - Cc) andalso (Ar - Br) == (Ac - Bc)).