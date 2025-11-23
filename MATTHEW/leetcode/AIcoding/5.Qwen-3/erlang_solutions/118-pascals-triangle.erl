-module(pascals_triangle).
-export([generate/1]).

generate(0) -> [];
generate(1) -> [[1]];
generate(N) ->
    Previous = generate(N-1),
    LastRow = lists:last(Previous),
    NewRow = [1 | [X + Y || {X,Y} <- lists:zip(LastRow, tl(LastRow))]],
    Previous ++ [NewRow].