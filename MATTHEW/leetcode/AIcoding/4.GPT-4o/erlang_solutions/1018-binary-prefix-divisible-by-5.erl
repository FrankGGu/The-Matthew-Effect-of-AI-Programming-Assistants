-module(solution).
-export([prefixes_div_by_5/1]).

prefixes_div_by_5(B) ->
    lists:map(fun(Prefix) -> (binary_to_integer(Prefix) rem 5) =:= 0 end,
                lists:map(fun(X) -> lists:sublist(B, 0, X) end,
                            lists:seq(1, length(B)))).