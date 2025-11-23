-module(solution).
-export([maximum_even_split/1]).

-spec maximum_even_split(FinalSum :: integer()) -> [integer()].
maximum_even_split(FinalSum) when FinalSum rem 2 =/= 0 ->
    [];
maximum_even_split(FinalSum) when FinalSum =< 0 ->
    [];
maximum_even_split(FinalSum) ->
    lists:reverse(maximum_even_split_helper(FinalSum, 2, 0, [])).

maximum_even_split_helper(FinalSum, CurrentEven, CurrentSum, Acc) ->
    if
        CurrentSum + CurrentEven =< FinalSum ->
            maximum_even_split_helper(FinalSum, CurrentEven + 2, CurrentSum + CurrentEven, [CurrentEven | Acc]);
        true ->
            [LastAddedElement | RestAcc] = Acc,
            Remaining = FinalSum - CurrentSum,
            [LastAddedElement + Remaining | RestAcc]
    end.