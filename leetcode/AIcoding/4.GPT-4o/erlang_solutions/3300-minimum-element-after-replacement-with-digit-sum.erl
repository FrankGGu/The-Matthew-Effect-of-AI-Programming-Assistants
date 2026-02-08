-module(solution).
-export([minimum_element_after_replacement/1]).

minimum_element_after_replacement(List) ->
    lists:min(lists:map(fun(X) -> digit_sum(X) end, List)).

digit_sum(N) when N < 10 -> N;
digit_sum(N) -> digit_sum(digit_sum_helper(N)).

digit_sum_helper(0) -> 0;
digit_sum_helper(N) -> N rem 10 + digit_sum_helper(N div 10).