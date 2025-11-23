-module(max_points_on_a_line).
-export([max_points/1]).

max_points([]) -> 0;
max_points([_]) -> 1;
max_points(Points) ->
    lists:max([count_points(P, Points) || P <- Points]).

count_points(P, Points) ->
    count_points(P, Points, #{}).

count_points(_, [], D) -> maps:size(D) + 1;
count_points(P, [Q | Rest], D) ->
    if
        P == Q -> count_points(P, Rest, D);
        true ->
            {dx, dy} = get_slope(P, Q),
            Key = {dx, dy},
            NewD = maps:update_with(Key, fun(V) -> V + 1 end, 1, D),
            count_points(P, Rest, NewD)
    end.

get_slope({X1, Y1}, {X2, Y2}) ->
    Dx = X2 - X1,
    Dy = Y2 - Y1,
    if
        Dx == 0 -> {0, 1};
        Dy == 0 -> {1, 0};
        true ->
            Gcd = gcd(abs(Dx), abs(Dy)),
            {Dx div Gcd, Dy div Gcd}
    end.

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, B) when B == 0 -> A;
gcd(A, B) -> gcd(B, A rem B).