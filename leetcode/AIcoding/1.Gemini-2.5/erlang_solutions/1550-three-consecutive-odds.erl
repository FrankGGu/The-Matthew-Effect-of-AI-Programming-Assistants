-module(solution).
-export([three_consecutive_odds/1]).

three_consecutive_odds(Arr) ->
    check_odds(Arr, 0).

check_odds([], _ConsecutiveOddCount) ->
    false;
check_odds([H|T], ConsecutiveOddCount) ->
    case H rem 2 =/= 0 of
        true ->
            NewCount = ConsecutiveOddCount + 1,
            if NewCount >= 3 ->
                    true;
               true ->
                    check_odds(T, NewCount)
            end;
        false ->
            check_odds(T, 0)
    end.