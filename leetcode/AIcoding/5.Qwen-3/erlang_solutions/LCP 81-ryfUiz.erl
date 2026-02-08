-module(solution).
-export([main/0]).

main() ->
    Args = init:get_arguments(),
    [Input] = Args,
    [N] = string:to_integer(Input),
    io:format("~p~n", [nand(N)]).

nand(0) -> 1;
nand(1) -> 0;
nand(N) when N > 1 ->
    nand(N-1) + nand(N-2).