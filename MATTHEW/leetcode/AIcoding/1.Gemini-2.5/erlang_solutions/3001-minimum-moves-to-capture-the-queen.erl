-module(solution).
-export([minMovesToCaptureTheQueen/6]).

minMovesToCaptureTheQueen(R1, C1, R2, C2, RQ, CQ) ->
    RookCanCapture = check_rook_capture(R1, C1, R2, C2, RQ, CQ),
    BishopCanCapture = check_bishop_capture(R1, C1, R2, C2, RQ, CQ),

    if
        RookCanCapture orelse BishopCanCapture -> 1;
        true -> 2
    end.

check_rook_capture(RookR, RookC, BishopR, BishopC, QueenR, QueenC) ->
    if
        RookR == QueenR ->
            % Rook is on the same row as Queen
            BlockedByBishop = (BishopR == RookR) andalso
                              ((BishopC > RookC andalso BishopC < QueenC) orelse
                               (BishopC < RookC andalso BishopC > QueenC)),
            not BlockedByBishop;
        RookC == QueenC ->
            % Rook is on the same column as Queen
            BlockedByBishop = (BishopC == RookC) andalso
                              ((BishopR > RookR andalso BishopR < QueenR) orelse
                               (BishopR < RookR andalso BishopR > QueenR)),
            not BlockedByBishop;
        true ->
            % Rook is not on the same row or column as Queen
            false
    end.

check_bishop_capture(RookR, RookC, BishopR, BishopC, QueenR, QueenC) ->
    if
        math:abs(BishopR - QueenR) == math:abs(BishopC - QueenC) ->
            % Bishop is on the same diagonal as Queen
            IsRookOnSameDiagonalAndCollinear = 
                (math:abs(RookR - QueenR) == math:abs(RookC - QueenC)) andalso
                (math:abs(RookR - BishopR) == math:abs(RookC - BishopC)),

            if
                IsRookOnSameDiagonalAndCollinear ->
                    % Rook, Bishop, Queen are collinear on a diagonal
                    % Check if Rook is strictly between Bishop and Queen
                    RookIsBetween = (RookR > erlang:min(BishopR, QueenR) andalso RookR < erlang:max(BishopR, QueenR));
                    not RookIsBetween; % If Rook is between, it blocks (return false). Otherwise, it doesn't (return true).
                true ->
                    % Rook is not on the same diagonal or not collinear, so it doesn't block the Bishop
                    true
            end;
        true ->
            % Bishop is not on the same diagonal as Queen
            false
    end.