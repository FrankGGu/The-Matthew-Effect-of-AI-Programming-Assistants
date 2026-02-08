-module(fair_distribution_of_cookies).
-export([distribute_cookies/2]).

distribute_cookies(Cookies, K) ->
    Len = length(Cookies),
    Initial_Bags = lists:duplicate(K, 0),
    min_unfairness(Cookies, Len, K, Initial_Bags, infinity).

min_unfairness([], _, _, Bags, Min) ->
    Max_Bag = lists:max(Bags),
    min(Min, Max_Bag);
min_unfairness([Cookie | Rest], Len, K, Bags, Min) ->
    Indices = lists:seq(1, K),
    New_Mins = [min_unfairness(Rest, Len, K, set_bag(Bags, I, element(I, Bags) + Cookie), Min) || I <- Indices],
    lists:min([Min | New_Mins]).

set_bag(Bags, Index, Value) ->
    setelement(Index, Bags, Value).

min(A, B) ->
    if
        A < B -> A;
        true -> B
    end.

infinity() ->
    16#7fffffff#.