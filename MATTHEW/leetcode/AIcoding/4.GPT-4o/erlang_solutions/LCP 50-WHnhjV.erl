-module(solution).
-export([numJewelsInStones/2]).

numJewelsInStones(J, S) ->
    jewels = string:to_lower(J),
    stones = string:to_lower(S),
    lists:sum(lists:map(fun(X) -> if lists:member(X, jewels) -> 1; true -> 0 end end, string:to_list(stones))).