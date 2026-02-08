-module(solution).
-export([flower_game/2]).

-spec flower_game(N :: integer(), M :: integer()) -> integer().
flower_game(N, M) ->
    NOdd = (N + 1) div 2,
    NEven = N div 2,
    MOdd = (M + 1) div 2,
    MEven = M div 2,
    (NOdd * MEven) + (NEven * MOdd).