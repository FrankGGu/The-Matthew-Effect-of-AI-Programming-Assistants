-module(solution).
-export([maxNiceDivisors/1]).

maxNiceDivisors(N) when N =< 3 -> N;
maxNiceDivisors(N) ->
    case N rem 3 of
        0 -> math:pow(3, N div 3);
        1 -> math:pow(3, (N div 3) - 1) * 4;
        2 -> math:pow(3, N div 3) * 2
    end rem (10^9 + 7).