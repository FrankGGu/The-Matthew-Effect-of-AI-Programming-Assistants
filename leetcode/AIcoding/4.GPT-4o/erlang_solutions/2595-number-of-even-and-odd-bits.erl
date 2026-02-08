-module(solution).
-export([even_odd_bits/1]).

even_odd_bits(N) ->
    Even = lists:foldl(fun(B, Acc) -> Acc + (B band 1) end, 0, bin_to_list(N bsr 1)),
    Odd = lists:foldl(fun(B, Acc) -> Acc + (B band 1) end, 0, bin_to_list(N)),
    {Even, Odd}.

bin_to_list(0) -> [];
bin_to_list(N) -> [N band 1 | bin_to_list(N bsr 1)].