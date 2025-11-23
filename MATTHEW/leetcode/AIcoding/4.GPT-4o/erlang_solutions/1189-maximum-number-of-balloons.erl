-module(solution).
-export([max_balloons/1]).

max_balloons(Str) ->
    Counts = lists:foldl(fun(Char, Acc) ->
        case Char of
            $b -> Acc#counts{b = Acc#counts.b + 1};
            $a -> Acc#counts{a = Acc#counts.a + 1};
            $l -> Acc#counts{l = Acc#counts.l + 1};
            $o -> Acc#counts{o = Acc#counts.o + 1};
            $n -> Acc#counts{n = Acc#counts.n + 1};
            _ -> Acc
        end
    end, #counts{b = 0, a = 0, l = 0, o = 0, n = 0}, Str),
    MinBalloons = min(Counts#counts.b, min(Counts#counts.a, min(div(Counts#counts.l, 2), min(div(Counts#counts.o, 2), Counts#counts.n)))),
    MinBalloons.

-record(counts, {b = 0, a = 0, l = 0, o = 0, n = 0}).

min(X, Y) when X < Y -> X;
min(_, Y) -> Y.

div(X, Y) when Y > 0 -> X div Y;
div(_, _) -> 0.