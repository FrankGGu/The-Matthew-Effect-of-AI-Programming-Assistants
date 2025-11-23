-module(solution).
-export([integerBreak/1]).

integerBreak(N) when N == 2 -> 1;
integerBreak(N) when N == 3 -> 2;
integerBreak(N) ->
    case N rem 3 of
        0 ->
            power(3, N div 3);
        1 ->
            power(3, (N - 4) div 3) * 4;
        2 ->
            power(3, N div 3) * 2
    end.

power(_Base, 0) -> 1;
power(Base, Exp) -> Base * power(Base, Exp - 1).