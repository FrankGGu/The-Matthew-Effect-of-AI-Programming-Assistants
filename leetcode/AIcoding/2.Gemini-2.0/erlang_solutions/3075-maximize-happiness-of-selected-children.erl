-module(maximize_happiness).
-export([maximum_happiness/2]).

maximum_happiness(N, Candies) ->
    maximum_happiness(N, lists:sort(Candies), 0).

maximum_happiness(0, _, Acc) ->
    Acc;
maximum_happiness(N, [H|T], Acc) when H >= N ->
    Acc + 1;
maximum_happiness(N, [_|T], Acc) ->
    maximum_happiness(N, T, Acc).