-module(solution).
-export([maximum_wealth/1]).

maximum_wealth(Customers) ->
    lists:max(lists:map(fun(Customer) -> lists:sum(Customer) end, Customers)).