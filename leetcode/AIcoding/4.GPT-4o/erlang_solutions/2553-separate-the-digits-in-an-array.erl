-module(solution).
-export([separate_digits/1]).

separate_digits(Nums) ->
    lists:flatmap(fun(X) -> integer_to_list(X) end, Nums).