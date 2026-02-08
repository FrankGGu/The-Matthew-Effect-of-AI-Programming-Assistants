-module(three_consecutive_odds).
-export([is_three_consecutive_odds/1]).

is_three_consecutive_odds(Numbers) ->
    is_three_consecutive_odds(Numbers, 0).

is_three_consecutive_odds([], _) ->
    false;
is_three_consecutive_odds([H | T], Count) when H rem 2 == 1 ->
    case Count of
        2 -> true;
        _ -> is_three_consecutive_odds(T, Count + 1)
    end;
is_three_consecutive_odds([_ | T], _) ->
    is_three_consecutive_odds(T, 0).