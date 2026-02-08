-module(solution).
-export([pair_sum/1]).

-record(node, {val, next}).

pair_sum(List) ->
    {FirstHalf, SecondHalf} = split(List),
    calculate_max_twin_sum(FirstHalf, SecondHalf).

split(List) ->
    split_helper(List, [], []).

split_helper([], FirstHalf, SecondHalf) ->
    {FirstHalf, lists:reverse(SecondHalf)};
split_helper([H | T], FirstHalf, SecondHalf) ->
    split_helper(T, [H | SecondHalf], FirstHalf).

calculate_max_twin_sum([], []) ->
    0;
calculate_max_twin_sum([H1 | T1], [H2 | T2]) ->
    max(H1 + H2, calculate_max_twin_sum(T1, T2)).