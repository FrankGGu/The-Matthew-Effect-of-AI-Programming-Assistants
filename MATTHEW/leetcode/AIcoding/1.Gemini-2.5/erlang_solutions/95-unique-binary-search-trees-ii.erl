-module(solution).
-export([generateTrees/1]).

generateTrees(0) ->
    [];
generateTrees(N) ->
    generate(1, N).

generate(Start, End) when Start > End ->
    [nil];
generate(Start, End) ->
    [ {I, L, R} ||
        I <- lists:seq(Start, End),
        L <- generate(Start, I - 1),
        R <- generate(I + 1, End)
    ].