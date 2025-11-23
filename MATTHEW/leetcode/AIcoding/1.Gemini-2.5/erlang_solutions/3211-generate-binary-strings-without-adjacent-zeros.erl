-module(solution).
-export([generate_strings/1]).

generate_strings(0) ->
    [""];
generate_strings(N) when N > 0 ->
    {Ends0, Ends1} = solve_recursive(N),
    Ends0 ++ Ends1.

solve_recursive(1) ->
    {[$0], [$1]};
solve_recursive(N) when N > 1 ->
    {PrevEnds0, PrevEnds1} = solve_recursive(N - 1),
    CurrentEnds0 = [S ++ [$0] || S <- PrevEnds1],
    CurrentEnds1 = [S ++ [$1] || S <- PrevEnds0 ++ PrevEnds1],
    {CurrentEnds0, CurrentEnds1}.