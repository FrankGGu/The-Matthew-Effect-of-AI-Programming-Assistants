-module(solution).
-export([calculate/1]).

calculate(N) when N < 0 -> 0;
calculate(N) -> calculate(N, 0).

calculate(0, Acc) -> Acc;
calculate(N, Acc) -> 
    calculate(N - 1, Acc + N).