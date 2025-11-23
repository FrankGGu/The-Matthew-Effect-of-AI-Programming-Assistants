-module(count_of_matches_in_tournament).
-export([number_of_matches/1]).

number_of_matches(0) -> 0;
number_of_matches(1) -> 0;
number_of_matches(N) ->
    N div 2 + number_of_matches(N - N div 2).