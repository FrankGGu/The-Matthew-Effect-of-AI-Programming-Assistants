-module(solution).
-export([minimum_distance/2]).

minimum_distance(Word, Hand) ->
    Positions = lists:map(fun(C) -> char_to_position(C) end, string:to_list(Word)),
    calculate_distance(Positions, Hand, 0).

char_to_position(Char) ->
    case Char of
        $A -> {0, 0};
        $B -> {0, 1};
        $C -> {0, 2};
        $D -> {1, 0};
        $E -> {1, 1};
        $F -> {1, 2};
        $G -> {2, 0};
        $H -> {2, 1};
        $I -> {2, 2};
        $J -> {3, 0};
        $K -> {3, 1};
        $L -> {3, 2};
        $M -> {4, 0};
        $N -> {4, 1};
        $O -> {4, 2};
        $P -> {5, 0};
        $Q -> {5, 1};
        $R -> {5, 2};
        $S -> {6, 0};
        $T -> {6, 1};
        $U -> {6, 2};
        $V -> {7, 0};
        $W -> {7, 1};
        $X -> {7, 2};
        $Y -> {8, 0};
        $Z -> {8, 1}
    end.

calculate_distance([], _, Acc) -> Acc;
calculate_distance([H | T], Hand, Acc) ->
    case Hand of
        {Finger1, Finger2} ->
            Dist1 = calculate_single_distance(Finger1, H),
            Dist2 = calculate_single_distance(Finger2, H),
            calculate_distance(T, {H, Finger2}, Acc + min(Dist1, Dist2));
    end.

calculate_single_distance({X1, Y1}, {X2, Y2}) ->
    abs(X1 - X2) + abs(Y1 - Y2).