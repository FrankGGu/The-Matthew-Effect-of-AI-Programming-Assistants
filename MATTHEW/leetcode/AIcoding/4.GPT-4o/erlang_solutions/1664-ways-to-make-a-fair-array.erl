-module(solution).
-export([ways_to_make_fair/1]).

ways_to_make_fair(A) ->
    N = length(A),
    {LeftOdd, LeftEven, TotalOdd, TotalEven} = lists:foldl(fun(X, {L1, L2, T1, T2}) ->
        {L2 + T1, L1 + T2, T1 + (if is_odd(X) -> X; true -> 0 end), T2 + (if is_even(X) -> X; true -> 0 end)}
    end, {0, 0, 0, 0}, A),
    ways_to_make_fair_helper(A, 0, 0, LeftOdd, LeftEven, TotalOdd, TotalEven, 0).

ways_to_make_fair_helper([], _, _, _, _, _, _, Count) ->
    Count;
ways_to_make_fair_helper([H | T], OddSum, EvenSum, LeftOdd, LeftEven, TotalOdd, TotalEven, Count) ->
    NewOddSum = OddSum + (if is_odd(H) -> H; true -> 0 end),
    NewEvenSum = EvenSum + (if is_even(H) -> H; true -> 0 end),
    NewCount = Count + (if NewOddSum + (TotalEven - LeftEven) =:= NewEvenSum + (TotalOdd - LeftOdd) -> 1; true -> 0 end),
    ways_to_make_fair_helper(T, NewOddSum, NewEvenSum, LeftOdd + (if is_odd(H) -> H; true -> 0 end), LeftEven + (if is_even(H) -> H; true -> 0 end), TotalOdd, TotalEven, NewCount).

is_odd(X) -> X rem 2 =:= 1.
is_even(X) -> X rem 2 =:= 0.