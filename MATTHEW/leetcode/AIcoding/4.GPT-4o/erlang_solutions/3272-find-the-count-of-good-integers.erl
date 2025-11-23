-module(solution).
-export([count_good_integers/1]).

count_good_integers(N) ->
    count_good_helper(N, 0, 0).

count_good_helper(0, Count, _) -> Count;
count_good_helper(N, Count, LastDigit) ->
    NewCount = if LastDigit == 0 -> Count + 1; true -> Count end,
    NewLastDigit = N rem 10,
    if NewLastDigit == LastDigit -> count_good_helper(N div 10, NewCount, NewLastDigit);
    true -> count_good_helper(N div 10, NewCount, NewLastDigit)
    end.