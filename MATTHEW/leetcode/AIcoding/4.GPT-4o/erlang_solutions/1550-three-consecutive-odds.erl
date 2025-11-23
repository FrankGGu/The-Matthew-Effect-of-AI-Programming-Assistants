-module(solution).
-export([three_consecutive_odds/1]).

three_consecutive_odds(List) ->
    three_consecutive_odds(List, 0).

three_consecutive_odds([], _) ->
    false;
three_consecutive_odds([H|T], Count) when H rem 2 =:= 1 ->
    three_consecutive_odds(T, Count + 1);
three_consecutive_odds([_|T], _) ->
    three_consecutive_odds(T, 0);
three_consecutive_odds(_, 3) ->
    true.