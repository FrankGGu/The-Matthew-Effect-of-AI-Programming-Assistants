-module(solution).
-export([base_neg_two/1]).

base_neg_two(N) when N == 0 -> 
    "0";
base_neg_two(N) ->
    base_neg_two_helper(N, []).

base_neg_two_helper(0, Acc) ->
    lists:reverse(Acc);
base_neg_two_helper(N, Acc) ->
    R = N rem -2,
    N1 = (N - R) div -2,
    base_neg_two_helper(N1, [integer_to_list(R) | Acc]).