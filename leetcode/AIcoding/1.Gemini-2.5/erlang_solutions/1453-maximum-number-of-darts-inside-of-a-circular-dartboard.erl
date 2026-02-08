-module(solution).
-export([num_darts/2]).

distance_sq([X1, Y1], [X2, Y2]) ->
    DX = X2 - X1,
    DY = Y2 - Y1,
    DX*DX + DY*DY.

num_darts(Points, R) ->
    N = length(Points),
    Epsilon = 1.0e-9,
    R_sq = R*R,

    if N =< 1 -> N;
       true ->
            MaxDarts = 1,
            Pairs = generate_pairs(Points),

            lists:foldl(fun({P_i, P_j}, CurrentMax) ->
                D_sq = distance_sq(P_i, P_j),
                D = math:sqrt(D_sq),

                if D < Epsilon or D > 2*R + Epsilon ->
                    CurrentMax;
                true ->
                    [X1, Y1] = P_i,
                    [X2, Y2] = P_j,
                    MidX = (X1 + X2) / 2.0,
                    MidY = (Y1 + Y2) / 2.0,

                    H_sq = R_sq - (D/2.0)*(D/2.0),
                    H = math:sqrt(H_sq),

                    VecX = X2 - X1,
                    VecY = Y2 - Y1,

                    NormVecX = -VecY / D,
                    NormVecY = VecX / D,

                    C1X = MidX + H * NormVecX,
                    C1Y = MidY + H * NormVecY,
                    C2X = MidX - H * NormVecX,
                    C2Y = MidY - H * NormVecY,

                    Centers = [[C1X, C1Y], [C2X, C2Y]],

                    lists:foldl(fun(Center, CenterCurrentMax) ->
                        CurrentCount = lists:foldl(fun(P_k, Count) ->
                            DistFromCenter_sq = distance_sq(P_k, Center),
                            if DistFromCenter_sq =< R_sq + Epsilon ->
                                Count + 1;
                            true ->
                                Count
                            end
                        end, 0, Points),
                        max(CenterCurrentMax, CurrentCount)
                    end, CurrentMax, Centers)
                end
            end, MaxDarts, Pairs)
    end.

generate_pairs(Points) ->
    generate_pairs(Points, Points, []).

generate_pairs([], _, Acc) ->
    Acc;
generate_pairs([H | T], _, Acc) ->
    PairsWithH = lists:map(fun(P_j) -> {H, P_j} end, T),
    generate_pairs(T, [], Acc ++ PairsWithH).