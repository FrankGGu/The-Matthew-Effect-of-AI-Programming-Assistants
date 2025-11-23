-module(count_matches).
-export([number_of_matches/1]).

number_of_matches(N) ->
    number_of_matches(N, 0).

number_of_matches(1, Acc) ->
    Acc;
number_of_matches(N, Acc) ->
    Matches = N div 2,
    Remaining = N rem 2,
    number_of_matches(Matches + Remaining, Acc + Matches).