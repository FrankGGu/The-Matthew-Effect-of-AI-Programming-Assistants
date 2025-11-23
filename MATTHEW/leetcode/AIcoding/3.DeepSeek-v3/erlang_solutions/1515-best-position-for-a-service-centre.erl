-spec get_min_dist_sum(Positions :: [[integer()]]) -> float().
get_min_dist_sum(Positions) ->
    {X0, Y0} = initial_guess(Positions),
    solve(Positions, X0, Y0, 0.1, 0.000001).

initial_guess(Positions) ->
    SumX = lists:sum([X || [X, _Y] <- Positions]),
    SumY = lists:sum([Y || [_X, Y] <- Positions]),
    N = length(Positions),
    {SumX / N, SumY / N}.

solve(Positions, X, Y, Step, Eps) ->
    Dx = derivative(Positions, X, Y, 0.0001, fun(X1, Y1) -> X1 end),
    Dy = derivative(Positions, X, Y, 0.0001, fun(X1, Y1) -> Y1 end),
    Norm = math:sqrt(Dx * Dx + Dy * Dy),
    if
        Norm < Eps -> distance_sum(Positions, X, Y);
        true ->
            NewX = X - Step * Dx / Norm,
            NewY = Y - Step * Dy / Norm,
            NewSum = distance_sum(Positions, NewX, NewY),
            OldSum = distance_sum(Positions, X, Y),
            if
                NewSum < OldSum -> solve(Positions, NewX, NewY, Step, Eps);
                true -> solve(Positions, X, Y, Step / 2, Eps)
            end
    end.

derivative(Positions, X, Y, Delta, Selector) ->
    F1 = distance_sum(Positions, X + Delta, Y + Delta),
    F2 = distance_sum(Positions, X + Delta, Y - Delta),
    F3 = distance_sum(Positions, X - Delta, Y + Delta),
    F4 = distance_sum(Positions, X - Delta, Y - Delta),
    (F1 - F2 - F3 + F4) / (4 * Delta).

distance_sum(Positions, X, Y) ->
    lists:sum([math:sqrt((X - Xi) * (X - Xi) + (Y - Yi) * (Y - Yi)) || [Xi, Yi] <- Positions]).