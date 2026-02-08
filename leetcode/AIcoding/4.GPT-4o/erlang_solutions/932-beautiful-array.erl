-module(solution).
-export([beautiful_array/1]).

beautiful_array(N) ->
    generate(1, N).

generate(Start, End) when Start > End -> [] ;
generate(Start, End) ->
    Odd = [X || X <- lists:seq(Start, End), X rem 2 =:= 1],
    Even = [X || X <- lists:seq(Start, End), X rem 2 =:= 0],
    lists:append(generate(1, length(Odd)), generate(1, length(Even))).