-module(check_balanced_string).
-export([check_balanced/1]).

check_balanced(S) ->
    check_balanced(S, 0).

check_balanced([], 0) -> true;
check_balanced([], _) -> false;
check_balanced([H | T], Balance) ->
    NewBalance = case H of
        ?A -> Balance + 1;
        ?B -> Balance - 1;
        _ -> Balance
    end,
    if
        NewBalance < 0 -> false;
        true -> check_balanced(T, NewBalance)
    end.