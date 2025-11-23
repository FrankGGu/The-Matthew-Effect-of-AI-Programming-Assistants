-module(solution).
-export([teemo_attacking/2]).

teemo_attacking([], _Duration) -> 0;
teemo_attacking([_T], Duration) -> Duration;
teemo_attacking([T1, T2 | Rest], Duration) ->
    Diff = T2 - T1,
    Added = min(Duration, Diff),
    Added + teemo_attacking([T2 | Rest], Duration).