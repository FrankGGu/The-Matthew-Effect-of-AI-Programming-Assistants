-module(solution).
-export([minimumLines/1]).

minimumLines(StockPrices) ->
    case length(StockPrices) of
        0 -> 0;
        1 -> 0;
        2 -> 1;
        _ -> 
            P1 = hd(StockPrices),
            P2 = hd(tl(StockPrices)),
            Rest = tl(tl(StockPrices)),
            count_lines(P1, P2, Rest, 1)
    end.

count_lines(_P1, _P2, [], Count) ->
    Count;
count_lines([X1, Y1], [X2, Y2], [[X3, Y3] | Rest], Count) ->
    % Check collinearity of P1, P2, P3 using cross-multiplication:
    % (Y2 - Y1) * (X3 - X2) == (Y3 - Y2) * (X2 - X1)
    % The problem states x-coordinates are strictly increasing,
    % so (X2 - X1) > 0 and (X3 - X2) > 0.
    % This avoids division by zero and floating-point issues.
    DiffY1 = Y2 - Y1,
    DiffX1 = X2 - X1,
    DiffY2 = Y3 - Y2,
    DiffX2 = X3 - X2,

    IsCollinear = (DiffY1 * DiffX2 == DiffY2 * DiffX1),

    NewCount = if IsCollinear -> Count;
                 true -> Count + 1
               end,

    % For the next iteration, the current second point (P2) becomes the first point (P1),
    % and the current third point (P3) becomes the second point (P2).
    % This effectively shifts the window of three points (P_prev, P_curr, P_next)
    % to (P_curr, P_next, P_next_next).
    count_lines([X2, Y2], [X3, Y3], Rest, NewCount).